{smcl}
{* December 2018}{...}
{vieweralsosee "vc_bw" "help vc_bw"}{...}
{vieweralsosee "vc_reg" "help vc_reg"}{...}
{vieweralsosee "vc_bsreg" "help vc_bsreg"}{...}
{vieweralsosee "vc_graph" "help vc_graph"}{...}
{vieweralsosee "vc_predict" "help vc_predict"}{...}
{vieweralsosee "cv_regress" "help cv_regress"}{...}
{cmd:help egen kweight()}{right: ({browse "https://doi.org/10.1177/1536867X20953574":SJ20-3: st0613})}
{hline}

{title:Title}

{p2colset 5 18 20 2}{...}
{p2col:{cmd:kweight()} {hline 2}}Extension to generate kernel weights{p_end}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:egen} [{it:type}] {it:newvar} {cmd:=}
{cmd:kweight}{cmd:(}{it:varname}{cmd:)} {ifin}{cmd:,} {opt bw(#)} {opt pofr(#)} [{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{p2coldent:* {opt bw(#)}}indicate bandwidth to be used for estimating the kernel weights{p_end}
{p2coldent:* {opt pofr(#)}}indicate a point of reference that will be used to
estimate the kernel weights; points closer to the {cmd:pofr()} will have a higher weight{p_end}
{synopt:{cmd:kernel(}{help kweight##kernel:{it:kernel}}{cmd:)}}indicate which kernel function to be used in the
process; default is {cmd:kernel(gaussian)}{p_end}
{synoptline}
{p2colreset}{...}
{pstd}
* {cmd:bw()} and {cmd:pofr()} are required.

{marker kernel}{...}
{synoptset 20 tabbed}{...}
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
{synopt :{opt logistic}}logistic kernel function{p_end}
{synopt :{opt tricube}}tricube kernel function{p_end}
{synopt :{opt triweight}}triweight kernel function{p_end}
{p2coldent:* {opt liracine}}Li-Racine kernel for unordered data{p_end}
{p2coldent:* {opt liracine2}}Li-Racine kernel for ordered data{p_end}
{p2coldent:* {opt habbena}}Habbena kernel for ordered data{p_end}
{p2coldent:* {opt logdis}}log distance kernel for ordered data{p_end}
{p2coldent:* {opt dtrian}}triangular distance kernel for ordered data{p_end}
{synoptline}
{p2colreset}{...}
{pstd}
* Kernel functions for discrete data.  All bandwidths must lie between 0 and 1
for these kernels.


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:egen kweight()} creates a {it:newvar} of the optionally specified storage
type equal to {opt kweight(varname)} using a specified bandwidth, kernel
function, and point of reference.  This command produces the normalized kernel
weights.

{pstd}
The function {cmd:kweight()} creates the normalized kernel weights based on a
defined kernel function, a selected bandwidth, and a given point of reference.

{pstd}
Given this information, the weights are created as follows:

{pstd}
It first creates an auxiliary variable z defined as
z=(x-{cmd:pofr()})/{cmd:bw()}.

{pstd}
With this information, the normalized kernel weight is defined as
kw=kernel(z)/kernel(0), where kernel is any of the kernel functions indicated
above.

{pstd}
For discrete ordered data, distance from the point of interest is weighted
equally.


{marker Examples}{...}
{title:Examples}

{phang2}
{bf:. {stata "webuse nlswork"}}{p_end}
{phang2}
{bf:. {stata "set seed 1"}}{p_end}
{phang2}
{bf:. {stata "replace age=age+rnormal()*.5"}}{p_end}
{phang2}
{bf:. {stata "egen kwage_30a=kweight(age), pofr(30) bw(3)"}}{p_end}
{phang2}
{bf:. {stata "egen kwage_30b=kweight(age), pofr(30) bw(3) kernel(epan)"}}{p_end}
{phang2}
{bf:. {stata "egen kwage_30c=kweight(age), pofr(30) bw(6) kernel(biweight)"}}{p_end}

{pstd}
Visualizing the weights:{p_end}
{phang2}
{bf:. {stata "line kwage_30* age, sort"}}{p_end}


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
Help:  {helpb vc_bw},
{helpb vc_reg},
{helpb vc_bsreg},
{helpb vc_graph},
{helpb vc_predict},
{helpb cv_regress} (if installed){p_end}
