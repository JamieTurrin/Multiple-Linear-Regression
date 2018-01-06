LIBNAME mydata "/courses/d1406ae5ba27fe300 " access=readonly;
DATA new; set mydata.marscrater_pds;

/* exclude empty rows, and rows I won't use in analysis */
IF morphology_ejecta_1 ^= 'Rd'; /* exclude radial ejecta */
IF morphology_ejecta_1 ^= ' '; /* exclude empty rows in ejecta 1 */
IF morphology_ejecta_2 ^= ' '; /* exclude empty rows in ejecta 2 */

* use only craters with rampart_edge because previous assignments;
* showed rampart edges correlate with depth/diameter;
IF FIND(morphology_ejecta_1,'R') GE 1;

* From previous assignment I know mean crater diameter is 9.38 km.
* subtract crater mean to center the crater diameter;
centered_diam = diam_circle_image - 9.38;

* Latitude will also be an explanatory variable;
* Use absolute value of latitude, assuming relationship between latitude and depth is;
* symmetric about equator;
lat_abs = abs(latitude_circle_image);


* testing shows diameter is not linearly related to depth;
* try square root instead;
diam_sqrt = sqrt(diam_circle_image);

run;

* plot relationship of depth vs diameter to see if square root of diameter is better fit;
PROC GPLOT; PLOT depth_rimfloor_topog*diam_sqrt; 
run;


* Model data using multiple linear regression;
* Explanatory (X) variables are square root of diameter and absolute value of latitude;
* Response (Y) variable is crater depth;
PROC GLM;

	* /solution clparm produces 95% confidence intervals;
	model depth_rimfloor_topog = diam_sqrt lat_abs/solution clparm;
	
	* produce new data set with residuals so I can closely examine them next;
	OUTPUT residual=res student=stdres out=results;
run;
	
	
* produce Q-Q plot for standardized residuals;
PROC UNIVARIATE DATA=results;
	VAR stdres;
	QQPLOT stdres;	
run;


* plot standardized residuals;
PROC GPLOT;
	LABEL stdres = 'Standardized Residuals' depth_rimfloor_topog = 'Crater Depth';
	PLOT stdres*depth_rimfloor_topog/vref=0;
run;


* produce partial plots to see contribution of individual variables to regression model;
PROC REG PLOTS(MAXPOINTS=11000) PLOTS=(RStudentByLeverage);
	model depth_rimfloor_topog = diam_sqrt lat_abs/partial;
run;








