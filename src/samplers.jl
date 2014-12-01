# delegation of samplers

# utilities for constructing samplers
_replace_macrocall(fn::Function,x,sym::Symbol) = x

function _replace_macrocall(fn::Function,ex::Expr,sym::Symbol)
    if ex.head == :macrocall && ex.args[1] == sym
        fn(ex.args[2:end]...)
    else
        map_args = [_replace_macrocall(fn,a,sym) for a in ex.args]
        Expr(ex.head,map_args...)
    end
end

macro sampler(sig,ex)
    quote
        function $(esc(:rand))(r::AbstractRNG, $sig)
            $(_replace_macrocall(ex,symbol("@rand")) do ee
                :($(esc(:rand))(r,$ee))
            end)
        end
        function $(esc(:rand!))(r::AbstractRNG, $sig, A::AbstractArray)
            $(_replace_macrocall(ex,symbol("@rand")) do ee
                :($(esc(:rand!))(r,$ee,A::AbstractArray))
            end)
        end
    end
end


for fname in ["categorical.jl",
              "binomial.jl",
              "poisson.jl", 
              "exponential.jl",
              "gamma.jl", 
              "multinomial.jl",
              "vonmises.jl", 
              "vonmisesfisher.jl"]
              
    include(joinpath("samplers", fname))
end
