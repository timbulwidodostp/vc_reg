{smcl}
{* *! version 1.0.0  February 2020}{...}
{vieweralsosee "vc_bw" "help vc_bw"}{...}
{vieweralsosee "vc_bwalt" "help vc_bw"}{...}
{vieweralsosee "vc_reg" "help vc_reg"}{...}
{vieweralsosee "vc_preg" "help vc_preg"}{...}
{vieweralsosee "vc_bsreg" "help vc_bsreg"}{...}
{vieweralsosee "vc_graph" "help vc_graph"}{...}
{vieweralsosee "vc_predict" "help vc_predict"}{...}
{vieweralsosee "cv_regress" "help cv_regress"}{...}
{cmd:help vc_pack}{right: ({browse "https://doi.org/10.1177/1536867X20953574":SJ20-3: st0613})}
{hline}

{title:Title}

{p2colset 5 16 18 2}{...}
{p2col:{cmd:vc_pack} {hline 2}}Commands for the model selection, estimation,
and visualization of smooth varying-coefficient models{p_end}
{p2colreset}{...}

 
{marker description}{...}
{title:Description}

{pstd}
Nonparametric regressions are powerful statistical tools that can be used to
model relationships between dependent and independent variables with minimal
assumptions on the underlying functional forms.

{pstd}
Despite their potential benefits, these models have two weaknesses: 

{p 8 10 2}
- The added flexibility creates a curse of dimensionality.

{p 8 10 2}
- Procedures available for model selection, such as cross-validation, have a
high computational cost in samples with even moderate sizes.

{pstd}
An alternative to fully nonparametric models is semiparametric models that
combine the flexibility of nonparametric regressions with the structure of
standard models.

{pstd} 
This package fits a particular type of semiparametric models known as smooth
varying-coefficient models (SVCMs) (Hastie and Tibshirani 1993) based on
kernel regression methods, assuming a single smoothing variable.

{pstd}
These commands aim to facilitate bandwidth selection, model estimation, and
implementation of specification tests, as well as create visualizations of the
results.

{pstd}
In this package, you will find the following commands:

{pstd}
{helpb vc_bw} and {helpb vc_bwalt} are commands used for bandwidth selection,
using two maximization methods for the cross-validation procedure.

{pstd}
{helpb vc_reg}, {helpb vc_bsreg}, and {helpb vc_preg} are commands used for
the estimation of the SVCM, based on different strategies for the estimation
of the variance-covariance matrix of the coefficients.

{pstd}
{helpb vc_predict} is a command used for the estimation of predicted values,
predicted errors, and leave-one-out errors.  It also provides basic summary
statistics for the SVCM and performs the approximate F test for model
specification.

{pstd}
{helpb vc_test} is a command used to implement the J statistic specification
test, using a wild bootstrap procedure.

{pstd}
{helpb vc_graph} is a command used to obtain plots of the estimated smooth
coefficients after the model has been fit using {helpb vc_reg}, 
{helpb vc_bsreg}, or {helpb vc_preg}.

{pstd}
For details on the commands, please refer to Rios-Avila (2020).


{marker references}{...}
{title:References}

{phang}
Hastie, T., and R. J. Tibshirani. 1993. Varying-coefficient models (with
discussion).  {it:Journal of the Royal Statistical Society, Series B}
55: 757-796.

{phang}
Rios-Avila, F. 2020. Smooth varying-coefficient models in Stata.
{it:Stata Journal} 20: 647-679.
{browse "https://doi.org/10.1177/1536867X20953574"}.


{marker Author}{...}
{title:Author}

{pstd}
Fernando Rios-Avila{break}
Levy Economics Institute of Bard College{break}
Blithewood-Bard College{break}
Annandale-on-Hudson, NY{break}
friosavi@levy.org


{marker alsosee}{...}
{title:Also see}

{p 4 14 2}
Article:  {it:Stata Journal}, volume 20, number 3: {browse "https://doi.org/10.1177/1536867X20953574":st0613}{p_end}

{p 7 14 2}
Help:  {helpb vc_bw}, {helpb vc_bwalt}, {helpb vc_reg}, {helpb vc_preg}, 
{helpb vc_bsreg}, {helpb vc_graph}, {helpb vc_predict},
{helpb cv_regress} (if installed){p_end}
