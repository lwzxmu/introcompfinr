% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/efficient.frontier.R
\name{efficient.frontier}
\alias{efficient.frontier}
\title{Compute efficient frontier of risky assets}
\usage{
efficient.frontier(er, cov.mat, nport = 20, alpha.min = -0.5,
  alpha.max = 1.5, shorts = TRUE)
}
\arguments{
\item{er}{\samp{N x 1} vector of expected returns}

\item{cov.mat}{\samp{N x N} return covariance matrix}

\item{nport}{scalar, number of efficient portfolios to compute}

\item{alpha.min}{minimum value of \samp{alpha}, default is \samp{-.5}}

\item{alpha.max}{maximum value of \samp{alpha}, default is \samp{1.5}}

\item{shorts}{logical, if \samp{TRUE} then short sales (negative portfolio weights)
are allowed. If \samp{FALSE} then no asset is allowed to be sold short}
}
\value{
\item{call}{captures function call}
 \item{er}{\samp{nport x 1} vector of expected returns of efficient porfolios}
 \item{sd}{\samp{nport x 1} vector of standard deviations of efficient portfolios}
 \item{weights}{\samp{nport x N} matrix of weights of efficient portfolios}
}
\description{
The function constructs the set of mean-variance efficient portfolios that either allow all
assets to be sold short or not allow any asset to be sold short. The returned object is of class
\samp{Markowitz} for which there are \samp{print}, \samp{summary} and \samp{plot} methods.
}
\details{
If short sales are allowed (negative weights) then the set of efficient portfolios of risky
assets can be computed as a convex combination of any two efficient portfolios. It is convenient
to use the global minimum variance portfolio as one portfolio and an efficient portfolio with
target expected return equal to the maximum expected return of the assets under consideration as
the other portfolio. Call these portfolios \eqn{m} and \eqn{x}, respectively. Then for any number
\samp{alpha}, another efficient portfolio can be computed as \eqn{z=\alpha m+(1-\alpha)x}. If
short sales are not allowed, then the set of efficient portfolios is computed by repeated calls
to the function \samp{efficient.portfolio()}, with \samp{shorts=FALSE}, for a grid of target
expected returns starting at the expected return of the global minimum variance portfolio (not
allowing short sales) and ending at the expected return equal to the maximum expected return of
the assets under consideration.
}
\examples{
# construct the data
asset.names = c("MSFT", "NORD", "SBUX")
er = c(0.0427, 0.0015, 0.0285)
names(er) = asset.names
covmat = matrix(c(0.0100, 0.0018, 0.0011,
                  0.0018, 0.0109, 0.0026,
                  0.0011, 0.0026, 0.0199),
                nrow=3, ncol=3)
r.free = 0.005
dimnames(covmat) = list(asset.names, asset.names)

# tangency portfolio
tan.port <- tangency.portfolio(er, covmat, r.free)
# compute global minimum variance portfolio
gmin.port = globalMin.portfolio(er, covmat)

# compute portfolio frontier
ef <- efficient.frontier(er, covmat, alpha.min=-2,
                         alpha.max=1.5, nport=20)
attributes(ef)

plot(ef)
plot(ef, plot.assets=TRUE, col="blue", pch=16)
points(gmin.port$sd, gmin.port$er, col="green", pch=16, cex=2)
points(tan.port$sd, tan.port$er, col="red", pch=16, cex=2)
text(gmin.port$sd, gmin.port$er, labels="GLOBAL MIN", pos=2)
text(tan.port$sd, tan.port$er, labels="TANGENCY", pos=2)
sr.tan = (tan.port$er - r.free)/tan.port$sd
abline(a=r.free, b=sr.tan, col="green", lwd=2)
}
\author{
Eric Zivot
}

