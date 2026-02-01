{smcl}
{* *! version 2.0.0  July 2019 Fernando Rios Avila}{...}
{vieweralsosee "vc_bw" "help vc_bw"}{...}
{vieweralsosee "vc_bwalt" "help vc_bw"}{...}
{vieweralsosee "vc_reg" "help vc_reg"}{...}
{vieweralsosee "vc_preg" "help vc_reg"}{...}
{vieweralsosee "vc_bsreg" "help vc_reg"}{...}
{vieweralsosee "vc_predict" "help vc_predict"}{...}
{vieweralsosee "cv_regress" "help cv_regress"}{...}
{cmd:help vc_graph}{right: ({browse "https://doi.org/10.1177/1536867X20953574":SJ20-3: st0613})}
{hline}

{title:Title}

{p2colset 5 17 19 2}{...}
{p2col:{cmd:vc_graph} {hline 2}}Command for plotting coefficients obtained
with vc_reg or vc_bsreg{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}
Smooth varying-coefficient model: Coefficient plots

{p 8 16 2}
{cmd:vc_graph}
[{varlist}]
[{cmd:,} {it:options}]
 
{pstd}
{it:varlist} may contain any of or all the variables used for the estimation of
the varying-coefficient model in {cmd:vc_reg} or {cmd:vc_bsreg}.

{synoptset 15}{...}
{synopthdr}
{synoptline}
{synopt:{opt ci(#)}}indicate the level of the confidence interval in
percentage; default is {cmd:ci(95)} normal-based confidence interval{p_end}
{synopt:{opt constant}}use this option when the interest is on plotting the
constant{p_end}
{synopt:{opt delta}}use this option when the interest is on plotting rate of
change of the coefficients with respect to the smoothing variable;
can be used in combination with {cmd:constant};
for any given model with the form
y=a0(z)+b0(z)*X+a1(z)*delta+b1(z)*X*delta, where delta=(z-z0), this option
will plot the coefficients b1; the default is to plot the coefficients b0; if used in combination with
{cmd:constant}, it will plot the coefficient a1(z) as well{p_end}
{synopt:{opt xvar(xvarname)}}request to use an alternative variable to create
the coefficient plots; this new variable should be a monotonic transformation
of the original smoothing variable h=h(z);
for example, one can use lz=log(z) to fit the smooth
varying-coefficient models (SVCMs) but decide to use Z to plot the
coefficients; in this case, one would use {cmd:xvar(z)}{p_end}
{synopt:{opt graph(stub)}}provide a {it:stub} to be used as a prefix for the
created plots, which are saved in memory; default is {cmd:graph(grph)}; graphs are named consecutively{p_end}
{synopt:{opt rarea}}request using "area" graph for the estimation of the
confidence intervals; default is to use {cmd:rcap}{p_end}
{synopt:{opt ci_off}}request to plot only the point estimates but not the confidence intervals{p_end}
{synopt:{opt pci}}when using {helpb vc_bsreg}, one can request to
plot the percentile-based confidence intervals rather than normal-based
intervals;
cannot be used in combination with {opt ci(#)}{p_end}
{synopt:{opt addgraph(str)}}request to add a plot to the generated graph;
for example, {cmd:vc_graph x1, addplot(scatter g x1)} will create a
{cmd:twoway} graph that includes the {cmd:scatter g x1}{p_end}
{synoptline}
{p2colreset}{...}
 

{marker description}{...}
{title:Description}

{pstd}
{cmd:vc_graph} is a command used to plot the coefficients of the SVCM, using
all the points of reference used in {cmd:vc_reg}, {cmd:vc_preg}, or
{cmd:vc_bsreg}.  You can choose to plot all the coefficients estimated of the
model [that is, b(z)] or the rate of change of those coefficients with respect
to z [that is, db(z)/dz].

{pstd}
The command also allows you to plot the figures using a variable different
from the original {cmd:vcoeff()} variable.  The alternative variable should be
a monotonic transformation from the original variable.  For example, one may
want to estimate the varying coefficients with respect to log(z) but plot the
figures with respect to z.

{pstd}
If B(z0) is the smooth coefficient around the point z0 and h=h(z) is a
monotonic transformation of z, then B(h0) is also the smooth coefficient
around the point h0.  This can be used to implement an alternative strategy to
the use of adaptive bandwidth for segments where the distribution of Z is
sparse.

{pstd}
Two or more points of reference are needed to be estimated to use
{cmd:vc_graph}.

{pstd}
Details on the command can be found in Rios-Avila (2020).


{marker examples}{...}
{title:Examples}

{pstd}
Fitting the SVCM for acceleration as a function of time{p_end}
{pstd}
Defining bandwidth{p_end}
{phang2}
{bf:. {stata "webuse motorcycle"}}{p_end}
{phang2}
{bf:. {stata "vc_bw accel, vcoeff(time)"}}{p_end}

{pstd}
Estimating the smooth varying coefficients{p_end}
{phang2}
{bf:. {stata "vc_reg accel, vcoeff(time) klist( 2.4/57.6) robust"}}{p_end}
{phang2}
{bf:. {stata "vc_graph, constant"}}{p_end}
{phang2}
{bf:. {stata "vc_graph, delta constant"}}{p_end}
{phang2}
{bf:. {stata "generate lntime=ln(time)"}}{p_end}
{phang2}
{bf:. {stata "generate sqtime=time^2"}}{p_end}
{phang2}
{bf:. {stata "vc_graph, delta constant xvar(sqtime)"}}{p_end}
{phang2}
{bf:. {stata "vc_graph, delta constant xvar(lntime)"}}{p_end}

{pstd}
Fitting SVCM for {cmd:dui.dta}{p_end}
{phang2}
{bf:. {stata "webuse dui, clear"}}{p_end}
{phang2}
{bf:. {stata "vc_bw citations i.csize college taxes, vcoeff( fines )"}}{p_end}
{phang2}
{bf:. {stata "vc_reg citations i.csize college taxes, vcoeff( fines ) bw(.7398) klist(7.4(.2)12) robust"}}{p_end}
{phang2}
{bf:. {stata "vc_graph i.csize college taxes, constant"}}{p_end}
{phang2}
{bf:. {stata "vc_graph i.csize college taxes, delta"}}{p_end}

{pstd}
Normal transformation for {cmd:fines}{p_end}
{phang2}
{bf:. {stata "summarize fines"}}{p_end}
{phang2}
{bf:. {stata "generate Fn=normal((fines-r(mean))/r(sd))"}}{p_end}

{pstd}
Graph against the normal percentile{p_end}
{phang2}
{bf:. {stata "vc_graph i.csize college taxes, constant xvar(Fn)"}}{p_end}
{phang2}
{bf:. {stata "vc_graph i.csize college taxes, delta xvar(Fn)"}}{p_end}


{marker references}{...}
{title:Reference}

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
Help:  {helpb vc_bw},
{helpb vc_bwalt}, {helpb vc_reg}, {helpb vc_preg}, {helpb vc_bsreg}, 
{helpb vc_predict}, {helpb cv_regress} (if installed){p_end}
