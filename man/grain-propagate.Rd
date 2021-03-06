% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/propagate.R
\name{grain-propagate}
\alias{grain-propagate}
\alias{propagate.grain}
\alias{propagateLS}
\alias{propagateLS__}
\alias{propagate__}
\title{Propagate a graphical independence network (a Bayesian network)}
\usage{
\method{propagate}{grain}(object, details = object$details, ...)

propagate__(object, details = object$details, ...)

propagateLS(cqpotList, rip, initialize = TRUE, details = 0)
}
\arguments{
\item{object}{A grain object}

\item{details}{For debugging info}

\item{...}{Currently not used}

\item{cqpotList}{Clique potential list}

\item{rip}{A rip ordering}

\item{initialize}{Always true}
}
\value{
A compiled and propagated grain object.
}
\description{
Propagation refers to calibrating the cliques of the
    junction tree so that the clique potentials are consistent on
    their intersections
}
\details{
The \code{propagate} method invokes \code{propagateLS}
    which is a pure R implementation of the Lauritzen-Spiegelhalter
    algorithm.

The function \code{propagate__} invokes \code{propagateLS__} which
is a c++ implementation of the Lauritzen-Spiegelhalter algorithm.

The c++ based version is several times faster than the purely R
based version, and after some additional testing the c++ based
version will become the default.
}
\examples{


yn   <- c("yes","no")
a    <- cptable(~asia,              values=c(1,99), levels=yn)
t.a  <- cptable(~tub+asia,          values=c(5,95,1,99), levels=yn)
s    <- cptable(~smoke,             values=c(5,5), levels=yn)
l.s  <- cptable(~lung+smoke,        values=c(1,9,1,99), levels=yn)
b.s  <- cptable(~bronc+smoke,       values=c(6,4,3,7), levels=yn)
e.lt <- cptable(~either+lung+tub,   values=c(1,0,1,0,1,0,0,1), levels=yn)
x.e  <- cptable(~xray+either,       values=c(98,2,5,95), levels=yn)
d.be <- cptable(~dysp+bronc+either, values=c(9,1,7,3,8,2,1,9), levels=yn)
plist <- compileCPT(list(a, t.a, s, l.s, b.s, e.lt, x.e, d.be))
pn    <- grain(plist)
pnc  <- compile(pn, propagate=FALSE)

if (require(microbenchmark))
    microbenchmark(
        propagate(pnc),
        propagate__(pnc) )

}
\author{
Søren Højsgaard, \email{sorenh@math.aau.dk}
}
\references{
Søren Højsgaard (2012). Graphical Independence
    Networks with the gRain Package for R. Journal of Statistical
    Software, 46(10), 1-26.
    \url{http://www.jstatsoft.org/v46/i10/}.
}
\seealso{
\code{\link{grain}}, \code{\link[gRbase]{compile}}
}
\keyword{models}
\keyword{utilities}

