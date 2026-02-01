{smcl}
{* *! version 3.0.0  July2019}{...}
{vieweralsosee "vc_bw" "help vc_bw"}{...}
{vieweralsosee "vc_bwalt" "help vc_bw"}{...}
{vieweralsosee "vc_graph" "help vc_graph"}{...}
{vieweralsosee "vc_predict" "help vc_predict"}{...}
{vieweralsosee "cv_regress" "help cv_regress"}{...}
{viewerjumpto "Syntax" "vc_reg##syntax"}{...}
{viewerjumpto "Description" "vc_reg##description"}{...}
{viewerjumpto "Options" "vc_reg##options"}{...}
{viewerjumpto "Remarks" "vc_reg##remarks"}{...}
{viewerjumpto "Examples" "vc_reg##examples"}{...}
{cmd:help vc_reg}, {cmd:help vc_preg}, {cmd:help vc_bsreg}{right: ({browse "https://doi.org/10.1177/1536867X20953574":SJ20-3: st0613})}
{hline}

{title:Title}

{p2colset 5 15 17 2}{...}
{p2col:{cmd:vc_reg} {hline 2}}Commands for the estimation of a smooth varying-coefficient model{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}
Varying-coefficient model with local linear errors and ordinary least-squares
(OLS) standard errors

{p 8 14 2}
{cmd:vc_reg}
{it:depvar} [{it:indepvar}]
{ifin}
[{cmd:,} {it:options}]


{pstd}
Varying-coefficient model with full sample error and OLS standard errors

{p 8 15 2}
{cmd:vc_preg}
{it:depvar} [{it:indepvar}]
{ifin}
[{cmd:,} {it:options} {it:vc_preg_options}]


{pstd}
Varying-coefficient model with bootstrap standard errors

{p 8 16 2}
{cmd:vc_bsreg}
{it:depvar} [{it:indepvar}]
{ifin}
[{cmd:,} {it:options} {it:vc_bsreg_options}]


{synoptset 25}{...}
{synopthdr:options}
{synoptline}
{synopt:{opt vcoeff(svar)}}indicate the variable to be used for the estimation
of the smooth varying-coefficient model (SVCM); default is to use the variable stored in global {cmd:$vcoeff_}, which was stored in memory after using {cmd:vc_bw} or {cmd:vc_bwalt}{p_end}
{synopt:{opt bw(#)}}provide a bandwidth for the estimation of the
SVCM; default uses the optimal bandwidth stored in global {cmd:$opbw_}
after using {cmd:vc_bw} or {cmd:vc_bwalt}{p_end}
{synopt:{cmd:kernel(}{help vc_reg##kernel:{it:kernel}}{cmd:)}}indicate which kernel function to use in
the varying-coefficient model; default is the one stored in global
{cmd:$kernel_} after using {cmd:vc_bw} or {cmd:vc_bwalt}{p_end}
{synopt:{opth cluster(varname)}}request the local linear cluster standard
errors; cannot be combined with {cmd:hc2} or {cmd:hc3}{p_end}
{synopt:{opt robust}}request the local linear robust standard errors{p_end}
{synopt:{opt hc2 hc3}}request the local linear {cmd:vce(hc2)} or
{cmd:vce(hc3)} standard errors{p_end}
{synopt:{opt k(#)}}indicate how many points will be used for the model
estimation; has to be an integer larger than 2; the points of reference 
are created to be equidistant between the 1st and 99th percentiles of the
sample of the empirical distribution of the smoothing variable; cannot be used with
{cmd:klist()}{p_end}
{synopt:{opth klist(numlist)}}indicate a list of numbers to be used for the
model estimation; if only one value is specified, the output of the model at
that point will be shown; cannot be used with {cmd:k()}{p_end}
{synoptline}

{synoptset 25}{...}
{synopthdr:vc_preg_options}
{synoptline}
{synopt:{opt knots(#k)} [{opt km(#km)}]}define how the full sample errors are
estimated; default is to use all distinct 
values in {opt vcoeff()}; {opt knots(#)} with a number equal or greater than 2
requests to estimate {it:#k} regressions using groups of equal width and simple average of the 
smoothing variable as point of reference; using {cmd:knots(0)} requests
estimating {it:#}=round[min{sqrt(N),10*log(N)/log(10)}]; similar criteria are used to choose number
of bins using histograms; if {cmd:knots(0)} is used, {cmd:km()} can be
requested to estimate {it:#km}*round(min(sqrt(N),10*log(N)/log(10)) regressions{p_end}
{synopt:{opth err(varname)} {opth lev(varname)}}to accelerate the estimation
of the standard errors, one can provide the command with errors and leverage
statistic estimated in a previous step; by default, the command estimates the full sample errors internally{p_end}
{synoptline}
 
{synoptset 25}{...}
{synopthdr:vc_bsreg_options}
{synoptline}
{synopt:{opt reps(#)}}indicate the number of repetitions for the bootstrap
process; default is {cmd:reps(50)}{p_end}
{synopt:{opt seed(#)}}set the seed number for the generation of bootstrap samples{p_end}
{synopt:{opth cluster(varname)}}provide a variable identifying resampling clusters{p_end}
{synopt:{opth strata(varname)}}provide a variable identifying strata{p_end}
{synopt:{opt pci(#)}}can be used to set the level of the percentile-based confidence intervals{p_end}
{synopt:{opt skf(#)}}provide a number that should be between 0 and 1; when this option is used, the bootstrap standard errors will be estimated using a smaller bandwidth than the one used for the point estimates{p_end}
{synoptline}
{p2colreset}{...}

{marker kernel}{...}
{synoptset 25}{...}
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
{cmd:vc_reg}, {cmd:vc_preg}, and {cmd:vc_bsreg} are commands used to fit SVCMs
using local linear kernel smoothing, as described in Rios-Avila (2020).  This
is done over a list of points of reference ({cmd:klist()}) or simply by
declaring a number of points ({cmd:k()}) across the data.  When one uses
{cmd:k()}, the points are chosen to be equidistant between the 1st and 99th
percentiles.  For example, {cmd:k(2)} will fit 2 models at the p1 and p99 of
the distribution.

{pstd}
When {cmd:vc_reg} or {cmd:vc_preg} is used, standard errors are estimated
using local errors, following the estimation proposed by Li and Racine (2007,
2010).  The default is to use robust standard errors, where the weights are
determined by the kernel and bandwidth used.  One can also request robust
standard errors, clustered standard errors, or those based on HC2 and HC3.

{pstd}
The difference between both commands is that {cmd:vc_reg} uses the local
linear predicted errors and leverage to estimate the coefficient's standard
errors.  In contrast, {cmd:vc_preg} uses the full sample errors and leverages.
This is done by either fitting the model errors and leverages for the whole
model internally or using predictions obtained in a previous step.

{pstd}
As with the command {helpb npregress}, one can also request bootstrap standard
errors, specifying the number of repetitions, cluster variables, or strata
variables.  The output reports normal-based confidence intervals, but one can
request percentile-based confidence intervals.

{pstd}
When bootstrap regressions are estimated, one can also request the estimation
of standard errors using a different bandwidth with the option {cmd:skf()}.
For example, using a value less than 1, say, 0.8, requests that bootstrap
standard errors be estimated using a bandwidth that is 20% less than the
bandwidth used for the main regression.  The default is {cmd:skf(1)}.

{pstd}
When only one point of reference is provided, all commands display the
standard regression output.  When two or more points of references are
provided, no output is provided.  Betas and variance matrices for each model
are stored separately as {cmd:e(b}{it:#}{cmd:)} and {cmd:e(V}{it:#}{cmd:)}.

{pstd}
In all cases, two matrices {cmd:e(betas)} and {cmd:e(stds)} are stored
containing the betas and standard errors for all the fitted models.  This can
be used for obtaining plots of the results; see {helpb vc_graph}.


{marker remarks}{...}
{title:Remarks}

{pstd}
This command fits a semiparametric model known as the SVCM (Hastie and
Tibshirani 1993).  Specifically, it fits a model that has the form

{phang2}
y=f0(z)+f1(z)*x1+f2(z)*x1+...+error

{pstd}
where f0(z), f1(z), ..., fk(z) are unknown nonlinear functions of z.

{pstd}
To fit this model, use the commands {cmd:vc_reg}, {cmd:vc_preg}, or
{cmd:vc_bsreg} to compute weighted regression in the neighborhood of some
point of reference z0, using a local linear approximation.  For any specific
point of reference, z0, the program fits a model of the following form:

{phang2}
y=a0+b0*x+a1*(z-z0)+b0*x*(z-z0)+e{p_end}

{pstd}
Call X=[1 x (z-z0) x*(z-z0)], and the estimation for the parameters B=[a0 a1
b0 b1]' are given by{p_end}

{phang2}
B=(X'W(z0)X)^-1 * X'W(z0)y{p_end}

{pstd}
with W(z) being a matrix of kernel weights depending on how close an
observation is to the point of interest z0.

{pstd}
Note that when no additional variables X are specified, the regression
provides estimates equivalent to those from {helpb lpoly} and
{helpb npregress kernel}.

{pstd}
{cmd:vc_reg} and {cmd:vc_preg} report the standard OLS standard errors using
weights and robust standard errors, as suggested in Li and Racine (2007,
2010).  Bootstrap standard errors can be obtained using {cmd:vc_bsreg}.

{pstd}
Further details on the commands, models, and estimation methods can be found
in Rios-Avila (2020).


{marker examples}{...}
{title:Examples}

{phang2}
{bf:. {stata "webuse motorcycle"}}{p_end}
{phang2}
{bf:. {stata "vc_bw accel, vcoeff(time)"}}{p_end}

{pstd}
Fitting model at time=25 using {cmd:vc_reg}{p_end}
{phang2}
{bf:. {stata "vc_reg accel, vcoeff(time) klist(25) robust"}}{p_end}

{pstd}
Same model using {cmd:vc_bsreg}{p_end}
{phang2}
{bf:. {stata "vc_bsreg accel, vcoeff(time) klist(25) reps(50) seed(1)"}}{p_end}
{phang2}
{bf:. {stata "estat bootstrap, percentile"}}{p_end}

{pstd}
Compared with {cmd:npregress}{p_end}
{phang2}
{bf:. {stata "quietly npregress kernel accel time, kernel(gaussian) bw($opbw_ $opbw_, copy)"}}{p_end}
{phang2}
{bf:. {stata "margins, at(time=25) reps(50) seed(1)"}}{p_end}
{phang2}
{bf:. {stata "margins, dydx(time) at(time=25) reps(50) seed(1)"}}{p_end}

{pstd}
Using {cmd:dui.dta}{p_end}
{phang2}
{bf:. {stata "webuse dui, clear"}}{p_end}
{phang2}
{bf:. {stata "vc_bw citations i.csize taxes college, vcoeff(fines)"}}{p_end}

{pstd}
Varying-coefficient model using local approximations{p_end}
{phang2}
{bf:. {stata "quietly vc_reg citations i.csize taxes college, vcoeff(fines) bw(0.7398) klist(9) robust"}}{p_end}
{phang2}
{bf:. {stata "estimates store m1a"}}{p_end}
{phang2}
{bf:. {stata "quietly vc_reg citations i.csize taxes college, vcoeff(fines) bw(0.7398) klist(10) robust"}}{p_end}
{phang2}
{bf:. {stata "estimates store m2a"}}{p_end}
{phang2}
{bf:. {stata "quietly vc_reg citations i.csize taxes college, vcoeff(fines) bw(0.7398) klist(11) robust"}}{p_end}
{phang2}
{bf:. {stata "estimates store m3a"}}{p_end}

{pstd}
Varying-coefficient model using full sample errors{p_end}
{phang2}
{bf:. {stata "quietly vc_preg citations i.csize taxes college, vcoeff(fines) bw(0.7398) klist(9) robust"}}{p_end}
{phang2}
{bf:. {stata "estimates store m1b"}}{p_end}
{phang2}
{bf:. {stata "quietly vc_preg citations i.csize taxes college, vcoeff(fines) bw(0.7398) klist(10) robust"}}{p_end}
{phang2}
{bf:. {stata "estimates store m2b"}}{p_end}
{phang2}
{bf:. {stata "quietly vc_preg citations i.csize taxes college, vcoeff(fines) bw(0.7398) klist(11) robust"}}{p_end}
{phang2}
{bf:. {stata "estimates store m3b"}}{p_end}

{pstd}
Varying-coefficient model using bootstrap standard errors{p_end}
{phang2}
{bf:. {stata "quietly vc_bsreg citations i.csize taxes college, vcoeff(fines) bw(0.7398) klist(9) seed(1)"}}{p_end}
{phang2}
{bf:. {stata "estimates store m1c"}}{p_end}
{phang2}
{bf:. {stata "quietly vc_bsreg citations i.csize taxes college, vcoeff(fines) bw(0.7398) klist(10) seed(1)"}}{p_end}
{phang2}
{bf:. {stata "estimates store m2c"}}{p_end}
{phang2}
{bf:. {stata "quietly vc_bsreg citations i.csize taxes college, vcoeff(fines) bw(0.7398) klist(11) seed(1)"}}{p_end}
{phang2}
{bf:. {stata "estimates store m3c"}}{p_end}
{phang2}
{bf:. {stata "esttab m1a m1b m1c m2a m2b m2c m3a m3b m3c, se noomit nogaps"}}{p_end}


{marker references}{...}
{title:References}

{phang}
Hastie, T., and R. J. Tibshirani. 1993. Varying-coefficient models (with
discussion).  {it:Journal of the Royal Statistical Society, Series B}
55: 757-796.

{phang}
Li, Q., and J. S. Racine. 2007. {it:Nonparametric Eonometrics: Theory and Practice}.
Princeton, NJ: Princeton University Press.

{phang}
------. 2010. Smooth varying-coefficient estimation and
inference for qualitative and quantitative data.
{it:Econometric Theory} 26: 1607-1637. 
{browse "https://doi.org/10.1017/S0266466609990739"}.

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


{marker alsosee}{...}
{title:Also see}

{p 4 14 2}
Article:  {it:Stata Journal}, volume 20, number 3: {browse "https://doi.org/10.1177/1536867X20953574":st0613}{p_end}

{p 7 14 2}
Help:  {helpb vc_bw}, {helpb vc_bwalt}, {helpb vc_graph}, {helpb vc_predict},
{helpb cv_regress} (if installed){p_end}
