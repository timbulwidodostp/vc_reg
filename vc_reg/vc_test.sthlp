{smcl}
{* *! version 2.0.0  July 2019 Fernando Rios Avila}{...}
{vieweralsosee "vc_bw" "help vc_bw"}{...}
{vieweralsosee "vc_bwalt" "help vc_bwalt"}{...}
{vieweralsosee "vc_reg" "help vc_reg"}{...}
{vieweralsosee "vc_reg" "help vc_preg"}{...}
{vieweralsosee "vc_bsreg" "help vc_bsreg"}{...}
{vieweralsosee "vc_graph" "help vc_graph"}{...}
{vieweralsosee "cv_regress" "help cv_regress"}{...}
{cmd:help vc_test}{right: ({browse "https://doi.org/10.1177/1536867X20953574":SJ20-3: st0613})}
{hline}
 
{title:Title}

{p2colset 5 16 18 2}{...}
{p2col:{cmd:vc_test} {hline 2}}Command used to implement J statistic wild
bootstrap specification test{p_end}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:vc_test}
{it:depvar} [{it:indepvars}]
{ifin}
[{cmd:,} {it:options}]

{synoptset 20}{...}
{synopthdr}
{synoptline}
{synopt:{opt vcoeff(svar)}}indicate the variable to be used for the estimation of smooth varying coefficients; the default option is to use the stored variable in global {cmd:$vcoeff_} after using {helpb vc_bw} or {helpb vc_bwalt}{p_end}
{synopt:{opt bw(#)}}used to provide a bandwidth for the estimation of the varying-coefficient model; the default option is to use the stored value in global {cmd:$opbw_} after using {helpb vc_bw} or {helpb vc_bwalt}{p_end}
{synopt:{cmd:kernel(}{help vc_test##kernel:{it:kernel}}{cmd:)}}indicate which kernel function to use in the varying-coefficient model; the default option is to use the stored value in global {cmd:$kernel_} after using {helpb vc_bw} or {helpb vc_bwalt}{p_end}
{synopt:{opt knots(#)}}request the estimation of {it:#} bins that will be used for the estimation of the predicted values and specification tests; the default is to use all distinct values in {cmd:vcoeff()}; using this option provides gains in speed at a cost of lower precision; when {cmd:knots(0)} is specified, the number of knots is given by 2*min{sqrt(N), 10*ln(N)/ln(10)}{p_end}
{synopt:{opt km(#)}}meant to be used in combination with {cmd:knots(0)}; when used, it requests to use knots=km* min{sqrt(N), 10*ln(N)/ln(10)}; default is {cmd:km(2)}{p_end}
{synopt:{opt degree(#d)}}specify the alternative parametric model that will be used as null hypothesis against the smooth varying-coefficient models; models 0 to 3 follow the same specification as the {helpb vc_predict} approximate F test{p_end}
{synopt:{opt wbsrep(#wb)}}specify the number of wild bootstrap samples to be used; default is {cmd:wbsrep(50)}{p_end}
{synoptline}
{p2colreset}{...}

{marker kernel}{...}
{synoptset 20}{...}
{synopthdr :kernel}
{synoptline}
{synopt :{opt gaussian}}Gaussian kernel function; the default{p_end}
{synopt :{opt epan}}Epanechnikov kernel function {p_end}
{synopt :{opt epan2}}alternative Epanechnikov kernel function{p_end}
{synopt :{opt biweight}}biweight kernel function{p_end}
{synopt :{opt cosine}}cosine trace kernel function{p_end}
{synopt :{opt parzen}}Parzen kernel function{p_end}
{synopt :{opt rectan}}rectangle kernel function{p_end}
{synopt :{opt trian}}triangle kernel function{p_end}
{synoptline}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
{cmd:vc_test} implements the specification test proposed by Cai, Fan, and Yao
(2000), based on a wild bootstrap approach, as described in Henderson and
Parmeter (2015).  The test statistic is constructed similarly to an F
statistic but without adjusting for degrees of freedom.

{pstd}
The wild bootstrap procedure is implemented under the null hypothesis that the
parametric model is correctly specified, and the empirical distribution of J
is used to find critical values to evaluate the null hypothesis.

{pstd}
The parametric model is defined using {cmd:degree()}, where each model is
defined as follows:

{pmore}
Model 0 y=xb0+gz+e

{pmore}
Model 1 y=xb0+gz+(z*x)b1+e

{pmore}
Model 2 y=xb0+gz+(z*x)b2+(z^2*x)b2+e

{pmore}
Model 3 y=xb0+gz+(z*x)b2+(z^2*x)b2+(z^3*x)b3+e

{pstd}
See Rios-Avila (2019) for details.


{marker examples}{...}
{title:Examples}

{pstd}
Specification test example{p_end}
{phang2}
{bf:. {stata "webuse motorcycle"}}{p_end}
{phang2}
{bf:. {stata "vc_bw accel, vcoeff(time)"}}{p_end}
{phang2}
{bf:. {stata "vc_test accel, vcoeff(time) degree(0)"}}{p_end}
{phang2}
{bf:. {stata "vc_test accel, vcoeff(time) degree(1)"}}{p_end}
{phang2}
{bf:. {stata "vc_test accel, vcoeff(time) degree(2)"}}{p_end}
{phang2}
{bf:. {stata "vc_test accel, vcoeff(time) degree(3)"}}{p_end}
 
{phang2}
{bf:. {stata "webuse dui, clear"}}{p_end}
{phang2}
{bf:. {stata "vc_bw citations taxes i.csize college, vcoeff(fines)"}}{p_end}

{phang2}
{bf:. {stata "vc_test citations taxes i.csize college, vcoeff(fines) degree(0)"}}{p_end}
{phang2}
{bf:. {stata "vc_test citations taxes i.csize college, vcoeff(fines) degree(0) wbsrep(100)"}}{p_end}

{phang2}
{bf:. {stata "vc_test citations taxes i.csize college, vcoeff(fines) degree(1)"}}{p_end}
{phang2}
{bf:. {stata "vc_test citations taxes i.csize college, vcoeff(fines) degree(1) wbsrep(100)"}}{p_end}

{phang2}
{bf:. {stata "vc_test citations taxes i.csize college, vcoeff(fines) degree(2)"}}{p_end}
{phang2}
{bf:. {stata "vc_test citations taxes i.csize college, vcoeff(fines) degree(2) wbsrep(100)"}}{p_end}


{marker references}{...}
{title:References}

{phang}
Cai, Z., J. Fan, and Q. Yao. 2000. Functional-coefficient regression models
for nonlinear time series.
{it:Journal of the American Statistical Association} 95: 941-956.
{browse "https://doi.org/10.1080/01621459.2000.10474284"}.

{phang}
Henderson, D. J., and C. F. Parmeter. 2015. 
{it:Applied Nonparametric Econometrics}. Cambridge: Cambridge University Press.

{phang}
Rios-Avila, F. 2020. Smooth varying-coefficient models in Stata.
{it:Stata Journal} 20: 647-679.
 {browse "https://doi.org/10.1177/1536867X20953574"}.

{phang}
Rios-Avila, F. 2019. A semi-parametric approach to the Oaxaca-Blinder
decomposition with continuous group variable and self-selection. 
{it:Econometrics} 7: 28.
{browse "https://doi.org/10.3390/econometrics7020028"}.


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
{helpb vc_bsreg}, {helpb vc_graph}, {helpb cv_regress} (if installed){p_end}
