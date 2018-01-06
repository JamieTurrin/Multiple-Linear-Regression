# Multiple-Linear-Regression
SAS program using multiple linear regression to model depth vs. diameter and latitude for Mars' craters

I modeled crater depth (the response variable) with 2 explanatory variables (crater diameter and latitude) using multiple regression. My hypothesis is that crater depth depends on both crater diamater and latitude; the null hypothesis is that crater depth does not depend on  either diameter or latitude. Plotting Depth vs Diameter revealed that Diameter is not linearly relatied to Depth,  instead the two appear to be related by the square root of Diameter. Plotting Depth vs Square Root of Diameter (see plot below) yields a linear relationship. So the model will include the Square Root of Diameter. Also, I chose to use the absolute value of Latitude, assuming that any relationship between Depth and Latitude is symmetric about the equator. The results of the generalized linear model (shown below) show that the two explanatory variables are statistically significant, both with p-values < 0.0001. The model is then defined as:

Depth = 0.31*SquareRootDiamter – 0.007*AbsoluteValueLatitude – 0.12

Note Latitude is negatively correlated with Depth, while Diameter is positively correlated.
The R2 value is 0.708 suggesting the model accounts for almost 71% of the variability in depth.
Both Beta values fall within the 95% confidence intervals, telling us that the Beta values are statistically significant.

The Q-Q plot for the standardized residuals is relatively straight between ±2 standard deviation, and then somewhat nonlinear beyond these limits. This suggests the model residuals are normally distributed around a mean of zero, which tells me the residuals are random.

The plot of standardized residuals vs Crater Depth shows that most residuals fall between ±2 standard deviations, which is good, but there is a noticeable positive linear trend in the residuals going from -2 to +2, suggesting there is some trend (a missing variable?) still unaccounted for.

The plot of residual by regressors shows that diameter appears uniformly distributed about 0 and is perhaps linear. Latitude is generally scattered about 0, but has a discontinuity near 40 degrees which is likely associated with a change in bedrock geology, according to the original research paper.

The Outlier and Leverage Diagnostics plot reveals a fair number of data points as outliers (beyond the ±2 standard deviations, shown as red circles), and a fair number of points with moderate leverage (green circles). There are 2 points with very high leverage, and 1 point far beyond 5 standard deviations away from the  mean, that could be removed to improve model accuracy.

