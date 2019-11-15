This is an example R Markdown file for Homework #2 in the IBIO*6000 class

# Instructions for Implementing the Assignment
I am going to start by checking to see what my working directory is
```{r}
getwd()
```
This is correct and as I intended because I am working within an R Project.  I don't need to change the working directory

Next I will import the datafile for this assignment.  The csv file was downloaded from CourseLink and is saved in my current working directory.
```{r}
cone.h<-read.csv("data/ConeHandling.csv", header=T) #remember to come up with your own file names that make sense to you.  ‘datafile’ is just an example.
```

Here I have called the data file cone.h rather than datafile since the latter is ambiguous.

I will then summarize some of the datafile as instructed in the assignment.
```{r}
length(cone.h)

names (cone.h)

length(cone.h$Trial)

summary (cone.h)
```

So there are 8 variables in the file.  The names of the variables are listed next.
There are 39 observations (trials).

## Description of Variables and their meanings

*Squirrel* - the identity of the person who performed the trial.  Note that each person performed 4-6 trials.  

*Trial* - The trial number (1-6)

*Length* - length of the cone (mm)

*Width* - width of the cone (mm)

*Handed* - direction that the cone was eaten (L = left-handed; R = right-handed)

*Chirality* - chirality of the cone (direction of the scales on the cone; D = dextral; S = sinistral)

*Time* - response variable.  Time taken to 'eat' the cone (seconds)

*Sex* - the gender of the assistant that performed the trial.  Note that this would more appropriately be labelled as geneder.  I was unaware of the biological sex of the field assistants.  I inferred their gender based on the way they presented themselves socially. (M = male; F = female)

## What is the mean width of cones?
Based on the summary output the mean width of cones is 13.86mm

## What is the se for the width of cones?

```{r}
sqrt(var(cone.h$Width)/length(cone.h$Width))
```

The se for the width of cones is 0.25 mm

##  Mean length of time to eat a cone
The mean length of time to eat a cone was 115.3 seconds

## SE for length of time to eat a cone
```{r}
sqrt(var(cone.h$Time)/length(cone.h$Time))
```
SE for the length of time to eat a cone is 6.82 seconds

# Exploratory Graphical Analysis
Relationship between the length of the cone and the amount of time taken to 'eat' it.

```{r}
plot(cone.h$Width, cone.h$Time)
```

We can add a trend line using abline
```{r}
plot(cone.h$Width, cone.h$Time)
abline(lm(Time~Width, data = cone.h))
```

Width is measured in mm and Time is measured in seconds.

It looks like the line underestimates Time for large cones.

# Model of Effect of Cone Width on Time to Eat
We can make a simple model of the effects of cone width on the length of time taken to eat the cone

```{r}
model<-lm(Time~Width, data = cone.h)
```


## Diagnostic plots
```{r}
plot(model)
```
In the first plot it is clear that the variance in the residuals increases with increasing fitted values.  Note that the plot looks like  afunnel opening to the right.

In the qq plot the normality of the residuals looks ok, but not great.

In the third plot, notice that there are three observations with large residuals (observations 4, 2, 31).  Notice, however, that they are moderate in their fitted values, meaning that they probably don't have a lot of leverage on the model.

The last plot shows that there are no observations with large Cook's distances (D > 0.5).  This confirms that while some points had large residuals they did not have high leverage on the model.


## Histigram of the Resdiauls

```{r}
hist(resid(model))
```

The histogram of the residuals suggests that there is some skewness in the residuals to the right.  Perhaps a log transformation would be appropriate here.

# Log-transformed Model
```{r}
model2<-lm(log(Time)~Width, data = cone.h)
hist(resid(model2))
```
Remember that in R, log = loge = ln and not log10.

These residuals look better.

Assessing the rest of the diagnostics
```{r}
plot(model2)
```


There is still heteroskedasticity in the residuals

The qq plot is better.

There are still some outlying observations, but none with large Cook's distances.

# GLM Results
```{r}
summary (model2)
```

The P-value for Width is very small.  Width is a significant predictor of handling time.
The effect of Width on Time was positive.
The regression equation for this model is log(Time) = 2.66 + 0.15 x Width


# Model with an Interaction
Note that this model includes Width as a covariate, but also includes chirality, handedness and an interaction between chirality and handedness.
We are interested in this interaction.
Note that time is log-transformed
```{r}
model3<-lm(log(Time)~Width+Chirality+Handed+Chirality:Handed, data=cone.h, na.action=na.omit)
```

## Diagnostics of the Interaction Model

```{r}
hist(resid(model3))
```

The residuals of the interaction model look pretty good.

```{r}
plot(model3)
```

There no longer seems to be heterioskedasticity in the residuals.  Note how the variance in residuals goes up but then goes back down again.  This is normal and OK.

The qq plot looks pretty good.

The residuals and Cook's distances look good.

## Results of the Interaction Model
```{r}
summary (model3)
```

There was a marginally significant interaction term.  So the effects of handedness did not appear to be constant.  Instead they seemed to depend on the chirality of the cone.  This effect is marginally significant though.

The R-squared above is 0.4945.  So 49% of the variation in handling time can be explained by cone width, the chirality of the cone, the handedness of the handler and the interaction between handedness and the chirality of the cone.

The F statistic refers to the significance of the model as a whole (p = 8.643e-05).  The t test statistic refers to the significance of each variable.

## Interaction Regression Equation
log(Time) = 2.83 + 0.14xWidth - 0.33xChiralityS - 0.068xHandednessR + 0.361xChiralitySxHandednessR

## anova output

```{r}
anova(model3)
```

Note that this is based on a Type-I SS so the order of the terms in the model matters.  For example, note that the p-value for Chirality has changed.

# Direction of Effects Graphics

Plot of residuals of our simpler model that only included Width against our two predictors that we are interested in.

```{r}
plot(cone.h$Handed:cone.h$Chirality, resid(model2))
```

So the y axis represents residuals after the effects of width are removed.  Remember that more positive values represent longer times and negative values represent faster times.
L:D represents left-handed eating of dextral cones.
L:S represents left-handed eating of sinistral cones.
R:D represents right-handed eating of dextral cones.
R:S represents right-handed eating of sinistral cones.


IMPORTANT: left-handed squirrels did NOT eat dextral cones faster than sinistral cones.  The more positive residuals meant that they actually took longer to eat dextral cones that sinistral cones.  There did not seem to be any difference in the length of time to eat dextral and sinistral cones for right-handed squirrels.

So the results did NOT support our prediction.  If anything, they were opposite to our predictions.

# Write-up

## Methods
The effects of cone chirality and squirrel handedness on the length of time taken (seconds) to harvest seeds from a spruce cone were assessed using a general linear model.  Since the length of time taken to harvest seeds from a cone likely depended on the size of the cone, I included the width of the cone (mm) as a covariate in the analysis.  Diagnostic plots from a simple model examining the relationship between cone width and handling time showed evidence of heteroscedasticity, in which the error variance increased with fitted values.  As a result, cone handling time was ln-transformed in all subsequent analyses.  Diagnostic plots of models based on the ln-transformed data indicated that residuals were approximately normally distributed, and there were no signs of heteroscedasticity or observations with undue influence on the relationship.  The hypothesis that left-handed squirrels eat dextral cones faster than sinistral cones and that right-handed squirrels eat dextral cones faster was tested by an interaction between handedness (coded as left- or right-handed) and chirality (dextral or sinistral).  All values are presented as means ± SE. All analyses were performed using R (R Core Team, 2015).

## Results
Spruce cones used for trials in this study averaged 13.86 ± 0.25mm in width.  Squirrels took an average of 115.3 ± 6.8 seconds to harvest seeds from the cones and the length of time taken to extract seeds from cones was positively correlated with the size of the cone eaten (B ± SE: 0.14 ± 0.03, t~34~ = 4.7, P < 0.001).  Overall, the model including cone width, handedness, cone chirality and the interaction between handedness and chirality explained 49% of the variation in cone harvesting time (F~4, 34~ = 8.3, P < 0.001).  As expected, there was not a consistent effect of cone chirality on the length of time taken to harvest seeds from cones, but the effect on cone chirality depended on the handedness of the squirrel (Chirality x handedness interaction B ± SE: 0.36 ± 0.18, t~34~ = 2.0, P = 0.051).  However, in contrast to my original prediction left-handed squirrels ate sinistral cones faster than dextral cones, whereas right-handed squirrels ate dextral and sinistral cones at about the same rate (Figure 1).  

## Reference
R Core Team, 2015. R: A language and environment for statistical computing.  R Foundation for Statistical Computing, Vienna, Austria. URL https://www.R-project.org.

# My Data
In my dataset I will be analyzing the effects of gender, degree sought (PhD or MSc), Homework2 grade and number of assignment pages on the grades of students in my class for Homework3.  In this case my replicates are students within my class.  Since each student only submitted one copy of Homework3 and I only plan to grade each assignment once there is no sub-sampling.  I also assume that all of the students prepared their homework assignments independently so that each grade should be an independent observation.  In my dataset gender and degree sought are categorical predictors similar to handedness and chirality, whereas Homework2 grade and #pages are continuous predictors (analogous to cone width).  I don’t have any reason to suspect that there will be interactions between any of these predictors.


```{r fig.cap = "Length of time taken for left- (L) and right-handed (R) red squirrels to harvest spruce seeds from dextral (D) and sinistral (S) spruce cones.  Values are corrected for the width of the cone and are presented as box plots for each combination of squirrel type and cone type."}
plot(cone.h$Handed:cone.h$Chirality, resid(model2))
```

## Note
I am still not sure why the location of the figure is not where I am trying to put it.


