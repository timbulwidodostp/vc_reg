{smcl}
{* *! version 2.0.0  July 2019 Fernando Rios Avila}{...}
{vieweralsosee "vc_bw" "help vc_bw"}{...}
{vieweralsosee "vc_bwalt" "help vc_bwalt"}{...}
{vieweralsosee "vc_reg" "help vc_reg"}{...}
{vieweralsosee "vc_reg" "help vc_preg"}{...}
{vieweralsosee "vc_bsreg" "help vc_bsreg"}{...}
{vieweralsosee "vc_graph" "help vc_graph"}{...}
{vieweralsosee "cv_regress" "help cv_regress"}{...}
{cmd:help vc_predict}{right: ({browse "https://doi.org/10.1177/1536867X20953574":SJ20-3: st0613})}
{hline}
 
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{cmd:vc_predict} {hline 2}}Command used to obtain predictions,
leave-one-out errors, and residuals for the smooth varying-coefficient
model{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 18 2}
{cmdab:vc_predict}
{it:depvar} [{it:indepvars}]
{ifin}
[{cmd:,} {it:options}]

{synoptset 20}{...}
{synopthdr}
{synoptline}
{synopt:{opt vcoeff(svar)}}indicate the variable to be used for the
estimation of smooth varying coefficients; default is to use the
stored variable in global {cmd:$vcoeff_} after using {helpb vc_bw} or {helpb vc_bwalt}{p_end}
{synopt:{opt bw(#)}}provide a bandwidth for the estimation of the
varying-coefficient model; default is to use the stored value in
global {cmd:$opbw_} after using {helpb vc_bw} or {helpb vc_bwalt}{p_end}
{synopt:{cmd:kernel(}{help vc_predict##kernel:{it:kernel}}{cmd:)}}indicate which kernel function to use in
the varying-coefficient model; default is to use the stored value
in global {cmd:$kernel_} after using {helpb vc_bw} or {helpb vc_bwalt}{p_end}
{synopt:{opth yhat(newvar)}}provide the name of a new variable in which to save the predicted values{p_end}
{synopt:{opth res(newvar)}}provide the name of a new variable in which to save the predicted residuals{p_end}
{synopt:{opth looe(newvar)}}provide the name of a new variable in which to save the predicted leave-one-out errors{p_end}
{synopt:{opth lvrg(newvar)}}provide the name of a new variable in which to save the predicted leverage points{p_end}
{synopt:{opt stest}}request specification test against parametric models that
use interactions with linear, quadratic, and cubic polynomials of the smooth coefficient, based on Hastie and Tibshirani (1990){p_end}
{synopt:{opt knots(#)}}request the estimation of {it:#} bins that
will be used for the estimation of the predicted values and specification
tests; default is to use all distinct values in {cmd:vcoeff()};
using this option provides gains in speed at a cost of lower precision; when
{cmd:knots(0)} is specified, the number of knots is given by min{sqrt(N),
10*ln(N)/ln(10)}{p_end}
{synopt:{opt km(#)}}meant to be used in combination with {cmd:knots(0)}; when
used, it requests to use knots=km* min{sqrt(N), 10*ln(N)/ln(10)}; default is
{cmd:km(1)}{p_end}
{synoptline}
{p2colreset}{...}

{marker kernel}{...}
{synoptset 20}{...}
{synopthdr :kernel}
{synoptline}
{synopt :{opt gaussian}}Gaussian kernel function; the default{p_end}
{synopt :{opt epan}}Epanechnikov kernel function{p_end}
{synopt :{opt epan2}}alternative Epanechnikov kernel function{p_end}
{synopt :{opt biweight}}biweight kernel function{p_end}
{synopt :{opt cosine}}cosine trace kernel function{p_end}
{synopt :{opt parzen}}Parzen kernel function{p_end}
{synopt :{opt rectan}}rectangle kernel function{p_end}
{synopt :{opt trian}}triangle kernel function{p_end}
{synoptline}
{p2colreset}{...}
{marker weight}{...}
{p 8 17 2}


{marker description}{...}
{title:Description}

{pstd}
{cmd:vc_predict} is a command used to obtain the model predictions,
leave-one-out errors, and leverage for smooth varying-coefficient models.  The
command also reports the R2 for the model as well as the average number of
kernel observations and degrees of freedom of the model and residuals.

{pstd}
The number of kernel observations is defined as the weighted sum of the
standardized kernel weight of all observations used for regressions in a
particular point of interest.

{pstd}
The number of degrees of freedom is defined as the sum of the leverage
statistics.  See Rios-Avila (2020) for details.


{marker remarks}{...}
{title:Remarks}

{pstd}
This command is used to obtain predicted values, predicted errors,
leave-one-out errors, and leverage errors for the smooth varying-coefficient
model.

{pstd}
The command requires one to specify all the variables for the model
specification as if using the command {helpb vc_reg}.  By default, information
about the kernel, bandwidth, and {cmd:vcoeff()} is taken from the macros
stored by {cmd:vc_bw} and {cmd:vc_bwalt}.

{pstd}
The default is to use all values defined in {cmd:vcoeff()} to obtain the model
predictions.  However, for an accelerated but less accurate estimate
prediction, one can use the {cmd:knots()} and {cmd:km()} options.  This
creates an internally used variable with less variation than the original
variable to fit the varying-coefficient models.

{pstd}
The command reports two measures of R2: one based on the sum of squares and
one based on the recommendation in Henderson and Parmeter (2015).

{pstd}
The expected number of kernel observations and degrees of freedom of the model
and degrees of freedom of the error are also reported.

{pstd}
The command also reports basic specification tests against a model with
polynomial interactions following an approximate F statistic as described in
Hastie and Tibshirani (1990).

{pstd}
Because the F test does not have a known distribution function, one can use
{cmd:vc_test} to implement the wild bootstrap J statistic.


{marker examples}{...}
{title:Examples}

{phang2}
{bf:. {stata "webuse motorcycle"}}{p_end}

{phang2}
{bf:. {stata "vc_bw accel, vcoeff(time)"}}{p_end}
{phang2}
{bf:. {stata "vc_predict accel, vcoeff(time) yhat(accel_hat1)"}}{p_end}
{phang2}
{bf:. {stata "scatter accel_hat1 time"}}{p_end}
 	  
{pstd}
Using {cmd:dui.dta}{p_end}
{phang2}
{bf:. {stata "webuse dui, clear"}}{p_end}
{phang2}
{bf:. {stata "vc_bw citations i.csize college taxes, vcoeff(fines)"}}{p_end}
{phang2}
{bf:. {stata "vc_predict citations i.csize college taxes, vcoeff(fines) stest"}}{p_end}
 

{marker references}{...}
{title:References}

{phang}
Hastie, T. J., and R. J. Tibshirani. 1990. {it:Generalized Additive Models}.
London: Chapman & Hall/CRC.

{phang}
Henderson, D. J., and C. F. Parmeter. 2015. 
{it:Applied Nonparametric Econometrics}. Cambridge: Cambridge University Press.

{phang}
Rios-Avila, F. 2020. Smooth varying-coefficient models in Stata.
{it:Stata Journal} 20: 647-679.
{browse "https://doi.org/10.1177/1536867X20953574"}.


{marker Author}{...}
{title:Author}

{pstd}Fernando Rios-Avila{break}
Levy Economics Institute of Bard College{break}
Blithewood-Bard College{break}
Annandale-on-Hudson, NY{break}
friosavi@levy.org


{title:Also see}

{p 4 14 2}
Article:  {it:Stata Journal}, volume 20, number 3: {browse "https://doi.org/10.1177/1536867X20953574":st0613}{p_end}

{p 7 14 2} 
Help:  {helpb vc_bw},
{helpb vc_bwalt},
{helpb vc_reg},
{helpb vc_preg},
{helpb vc_bsreg},
{helpb vc_graph},
{helpb cv_regress} (if installed){p_end}
