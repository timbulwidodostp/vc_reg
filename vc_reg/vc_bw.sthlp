{smcl}
{* *! version 2.0  Fernando Rios-Avila July 2019 }{...}
{vieweralsosee "vc_reg" "help vc_reg"}{...}
{vieweralsosee "vc_bsreg" "help vc_bsreg"}{...}
{vieweralsosee "vc_preg" "help vc_preg"}{...}
{vieweralsosee "vc_graph" "help vc_graph"}{...}
{vieweralsosee "vc_predict" "help vc_predict"}{...}
{vieweralsosee "cv_regress" "help cv_regress"}{...}
{cmd:help vc_bw}, {cmd:help vc_bwalt}{right: ({browse "https://doi.org10.1177/1536867X20953574/":SJ20-3: st0613})}
{hline}

{title:Title}

{p2colset 5 14 16 2}{...}
{p2col:{cmd:vc_bw} {hline 2}}Commands for model bandwidth selection for
smooth varying-coefficient models based on leave-one-out cross-validation{p_end}


{marker syntax}{...}
{title:Syntax}

{pstd}
Newton-Raphson-type algorithm

{p 8 13 2}
{cmdab:vc_bw} {it:depvar} [{it:indepvars}] {ifin}{cmd:,} {opt vcoeff(svar)} [{it:options}]


{pstd}
Bisection-type algorithm{p_end}

{p 8 16 2}
{cmdab:vc_bwalt} {it:depvar} [{it:indepvars}] {ifin}{cmd:,} {opt vcoeff(svar)} [{it:options}]


{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{p2coldent:* {opt vcoeff(svar)}}indicate the variable to be used for the estimation of smooth varying coefficients{p_end}
{synopt:{opt knots(#k)}}define how many knots will be used for the
cross-validation (CV) search; using this option will prebin the data in
{it:#k}+1 groups of equal bin; the default is to use all the distinct values of {cmd:vcoeff()} if they are
less than 500 distinct values; otherwise, it uses the nearest integer to
knots =2* min{sqrt(N), 10*ln(N)/ln(10)}; this is similar to the choice of
bins when using histograms; using {cmd:knots(0)} requests using knots =
min{sqrt(N), 10*ln(N)/ln(10)}; to request using all distinct values in
{cmd:vcoeff()},
use {cmd:knots(-2)}; any other positive number will be used directly as the
specified number of knots; when {cmd:knots()} is specified, the command will also report the implicit bin
width; the rule of thumb is for the ratio between the bin width and optimal bandwidth to be less than 0.3 (Gaussian kernel) or 0.1 otherwise (Hoti and Homstrom 2003){p_end}
{synopt:{opt km(#km)}}meant to be used in combination with {cmd:knots(0)}; it
indicates to use a number of knots defined by knots = {cmd:km()} * min{sqrt(N), 10*ln(N)/ln(10)}{p_end}
{synopt:{opt bwi(#)}}used to set the initial value for the bandwidth; the
default option uses the bandwidth
from the command {cmd:lpoly} using the same kernel function declared in {cmd:kernel()}{p_end}
{synopt:{opt trimsample(trimvar)}}provide a variable that indicates which
observations within the sample will be used for the calculation of the CV
criteria; this is used to reduce the influence of sparse data around the endpoints of
the distribution of the running variable ({cmd:vcoeff()}) for the estimation
of the optimal bandwidth; values of zero 
indicate that those observations will not be used for calculating the CV criteria (but are used in the local linear regression){p_end}
{synopt:{cmd:kernel(}{help vc_bw##kernel:{it:kernel}}{cmd:)}}indicate which kernel function to use in the
process; default is {cmd:kernel(gaussian)}{p_end}
{synopt:{opt plot}}request to provide the plot of the CV criteria and
bandwidths; use it when encountering problematic maximization areas and for visual inspection{p_end}
{synoptline}
{p2colreset}{...}
{pstd}
* {cmd:vcoeff()} is required.

{marker kernel}{...}
{synoptset 15}{...}
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


{marker description}{...}
{title:Description}

{pstd}
{cmd:vc_bw} and {cmd:vc_bwalt} are commands used to calculate the optimal
bandwidth for a smooth varying-coefficient model.  This is done by minimizing
a leave-one-out cross-validation (LOOCV) criterion.

{pstd}
{cmd:vc_bw} uses a Newton-Raphson algorithm to find the optimal bandwidth.
This should be more precise but may have difficulties in some cases where the
objective function is not differentiable or not concave.  See Rios-Avila
(2020) for a detailed algorithm.

{pstd}
{cmd:vc_bwalt} uses a bisection-type algorithm to find the optimal bandwidth.
This should have fewer problems finding the optimal bandwidth with all kernel
functions but might be less precise.  See Rios-Avila (2020) for details on the
algorithm.  The CV criterion is the log of the leave-one-out mean squared
error.  The leave-one-out errors are calculated over the data defined by the
{cmd:if} and {cmd:in} qualifiers, and the mean squared error is constrained to
the {cmd:trimsample()}.

{pstd}
While most algorithms use all distinct values in the smoothing variable
{cmd:vcoeff()} to find the optimal bandwidth, this command estimates the CV
criterion using local approximation based on binned data, defined by knots.
This strategy provides less accurate results but at a lower computational
cost.  Simulations show that the loss in precision is relatively small when
the ratio between the bin width and optimal bandwidth is small, with a large
gain in computational speed.  See Rios-Avila (2020) for details.
 

{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:vc_bw} uses numerical derivatives and a Newton-Raphson type of algorithm
to find the optimal bandwidth that minimizes the LOOCV criterion for a
corresponding smooth varying-coefficient model.  This is done using local
linear approximations and leverage to estimate the leave-one-out error.

{pstd}
{cmd:vc_bwalt} uses a bisection-type algorithm to find the optimal bandwidth
that minimizes the LOOCV criteria.  Details on both algorithms can be found in
Rios-Avila (2020).

{pstd}
While both commands can be used for all the standard kernel functions,
{cmd:vc_bc} may perform better with the Gaussian kernel.  {cmd:vc_bwalt} is
more likely to find a solution in cases with a more complex optimization
problem, for example, when using a rectangular kernel.

{pstd}
{cmd:vc_bc} may have difficulties finding the optimal bandwidth when the LOOCV
criterion is not differentiable.

{pstd}
As part of the output, a matrix is provided containing each bandwidth, and its
corresponding LOOCV criterion, estimated through the program.  It is suggested
to review this when encountering difficult or unexpected optimization
patterns.  One can also use the option {cmd:plot} to provide a simple scatter
of the CV and bandwidths.

{pstd}
When using {cmd:knots(0)} or {opt knots(#)}, one can accelerate the
optimization by performing a block CV procedure, similar to the one described
in H{c a:}rdle and Linton (1994).  Simulations show that the block
cross-validated bandwidths are close to the full-data optimal bandwidths with
large gains in computational speed.

{pstd}
After the program is finished, three global macros are set containing the
optimal bandwidth, the kernel used for the estimation, and the variable used
as the smoothing variable.  The commands {helpb vc_reg}, {helpb vc_bsreg}, and
{helpb vc_predict} use this information as the default.


{marker examples}{...}
{title:Examples}

{pstd}
Choosing optimal bandwidth for motorcycle data{p_end}
{phang2}
{bf:. {stata "webuse motorcycle"}}{p_end}
{phang2}
{bf:. {stata "vc_bw accel, vcoeff(time)"}}{p_end}
{phang2}
{bf:. {stata "vc_bwalt accel, vcoeff(time) plot"}}

{pstd}
Compared with {cmd:npregress} (available for Stata 15 or higher){p_end}
{phang2}
{bf:. {stata "npregress kernel accel time, noderiv kernel(gaussian)"}}

{pstd}
Using {cmd:dui.dta}{p_end}
{phang2}
{bf:. {stata "webuse dui, clear"}}{p_end}
{phang2}
{bf:. {stata "vc_bw citations, vcoeff(fines)"}}{p_end}
{phang2}
{bf:. {stata "vc_bwalt citations, vcoeff(fines)"}}{p_end}
{phang2}
{bf:. {stata "npregress kernel citations fines, kernel(gaussian) noderiv"}}{p_end}

{pstd}
Adding other explanatory variables{p_end}
{phang2}
{bf:. {stata "vc_bw citations taxes i.csize college, vcoeff(fines)"}}{p_end}
{phang2}
{bf:. {stata "vc_bwalt citations taxes i.csize college, vcoeff(fines) plot"}}{p_end}


{marker references}{...}
{title:References}

{phang}
H{c a:}rdle, W., and O. Linton. 1994. Applied nonparametric methods.
In {it:Handbook of Econometrics, vol. 4}, ed. R. Engle and D. McFadden,
2295-2339. Amsterdam: North-Holland. 
{browse "https://doi.org/10.1016/S1573-4412(05)80007-8"}.

{phang}
Hoti, F., and L. Holmstr{c o:}m. 2003. On the estimation error in binned local
linear regression.  {it:Journal of Nonparametric Statistics} 15: 625-642.
{browse "https://doi.org/10.1080/10485250310001605469"}.

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
Help:  {helpb vc_reg},
{helpb vc_bsreg},
{helpb vc_preg},
{helpb vc_graph},
{helpb vc_predict},
{helpb cv_regress} (if installed){p_end}
