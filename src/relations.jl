# relationships between distributions
# isequal
import Base.isequal

# discrete
isequal(x::Bernoulli,y::Binomial) = (y.size == 1) && (x.p1 == y.prob)
isequal(y::Binomial,x::Bernoulli) = (y.size == 1) && (x.p1 == y.prob)

isequal(x::Bernoulli,y::HyperGeometric) = (y.n == 1) && (x.p1 * y.nf == y.ns * x.p0)
isequal(y::HyperGeometric,x::Bernoulli) = (y.n == 1) && (x.p1 * y.nf == y.ns * x.p0)

isequal(x::Binomial,y::HyperGeometric) = (x.size == 1) && (y.n == 1) && (x.prob * (y.nf + y.ns) == y.ns)
isequal(y::HyperGeometric,x::Binomial) = (x.size == 1) && (y.n == 1) && (x.prob * (y.nf + y.ns) == y.ns)

isequal(x::Geometric,y::NegativeBinomial) = (y.size == 1.0) && (x.prob == y.prob)
isequal(y::NegativeBinomial,x::Geometric) = (y.size == 1.0) && (x.prob == y.prob)

# continuous
# full real line
isequal(x::TDist,y::Normal) = (x.df == Inf) && (y.mean == 0.0) && (y.std == 1.0)
isequal(y::Normal,x::TDist) = (x.df == Inf) && (y.mean == 0.0) && (y.std == 1.0)

isequal(x::TDist,y::Cauchy) = (x.df == 1.0) && (y.location = 0.0) && (y.scale == 1.0)
isequal(y::Cauchy,x::TDist) = (x.df == 1.0) && (y.location = 0.0) && (y.scale == 1.0)

# positive reals
isequal(x::Exponential,y::Gamma) = (y.shape == 1.0) && (x.scale == y.scale)
isequal(y::Gamma,x::Exponential) = (y.shape == 1.0) && (x.scale == y.scale)

isequal(x::Chisq,y::Gamma) = (0.5*x.df == y.shape) && (y.scale == 2.0)
isequal(y::Gamma,x::Chisq) = (0.5*x.df == y.shape) && (y.scale == 2.0)

isequal(x::Chisq,y::Exponential) = (x.df == 2.0) && (y.scale == 2.0)
isequal(y::Exponential,x::Chisq) = (x.df == 2.0) && (y.scale == 2.0)

isequal(x::Erlang,y::ContinuousUnivariateDistribution) = (x.nestedgamma == y)
isequal(y::Gamma,x::ContinuousUnivariateDistribution) = (x.nestedgamma == y)

isequal(x::Levy,y::InvertedGamma) = (x.location == 0.0) && (y.shape == 0.5) && (x.scale*y.scale == 2.0)
isequal(y::InvertedGamma,x::Levy) = (x.location == 0.0) && (y.shape == 0.5) && (x.scale*y.scale == 2.0)

isequal(x::Chi,y::Rayleigh) = (x.df == 2.0) && (y.scale == 1.0)
isequal(y::Rayleigh,x::Chi) = (x.df == 2.0) && (y.scale == 1.0)


# intervals
isequal(x::Uniform,y::Beta) = (x.a == 0.0) && (x.b == 1.0) && (y.alpha == 1.0) && (y.beta == 1.0)
isequal(y::Beta,x::Uniform) = (x.a == 0.0) && (x.b == 1.0) && (y.alpha == 1.0) && (y.beta == 1.0)

isequal(x::Arcsine,y::Beta) = (y.alpha == 0.5) && (y.beta == 0.5)
isequal(y::Beta,x::Arcsine) = (y.alpha == 0.5) && (y.beta == 0.5)


# TODO
# noncentral distributions