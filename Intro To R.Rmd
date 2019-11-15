# Welcome
Welcome to R!  This document will provide you with an introduction to R.  If you follow along and perform the various tasks as you move through the document you will get a decent introduction to R.  Feel free to fiddle around as you go.  Making mistakes is a great way to learn!!  

In this document you will find R code as well as the output from R as it will appear on your screen. This
document will provide in a lot of cases both the input and output of the R session. I recommend that as you work your way through the document, you type the code into R, instead of using copy-paste. This will allow you to get used to typing R code, and get used to trouble-shooting any error messages you will get.


One of the free programs that has been written to help you use R is called RStudio (http://rstudio.org).  RStudio is just a wrapper (convenient and prettier interface) for R.  We will use it in this course but know that this is not a different statistical program.  It is just a way of interacting with the statistical program R.

I will provide both a pdf copy of this document, but it has been created using RMarkdown in RStudio.  This program allows you to create PDFs or HTML like this of your work in R.  RStudio is a very useful interface for R and producing PDF documents like this will allow you to keep very careful notes about what you have done and be able to communicate these (to your supervisor, perhaps) so that it is perfectly clear what you have done.  As a supervisor, I require all of my students to leave me with an archive folder of all of their data and R code.  Having a document like this would then allow me to see exactly how they performed their analyses and to recreate their analyses.  This sort of paper trail is essential for the reproducability of scientific findings and will save a lot of time in the long-run if you get used to working in this format. 

# Opening and Navigating RStudio
## Console
Open RStudio.  It is in the Applications folder on the computer.  When RStudio first opens there will be a window on the left called the 'Console' and one on the right called 'Environment' or 'History"  You can ignore these ones on the right for now.

The Console represents your interface with R.  This is a Question and Answer type interface where you submit a command and often recieve some sort of output from R.  The > symbol indicates that R is ready to receive an input from you. 

## R as a Calculator
One of the simplest thing that R can be used for is simple calculations.  For example we can add two numbers together by typing 

```{r }
5+18
```
Note first that the output from R in this document is preceded by "##".  You will not see this in your console when you type in 5+18.
Second, the output of this command in the console will be preceded by the number 1 in square brackets. This is just an index for keeping track where the answer was put.  It actually means that it is the first value in a vector.  We will come back to that later.

We can also do other types of math within R...
```{r}
10*230

(10+10)/5+6

#versus

(10+10)/(5+6)

sqrt(81)

```
Note that in this document my code (what I have typed into R) is in the grey box and the output from R is right below this.

```{r}
log(10)

#Note that this is different from

log10(10)

exp(1)
```
Note that the ``log'' and ``exp'' functions refer to base e and not base 10.


## Storing Information
In addition to receiving the output directly, the result of a calculation can be stored as a new variable.

```{r}
x<-5+18

#or

x=5+18
```
Note that it looks like nothing happened here, but this was because we didn't ask R to respond.  All we asked it to do was create a new variable called x and make it equal to 5+18.  If we want to know what x is we just type in 'x' and R will tell us what it is.
```{r}
x
```
 
We can call a variable pretty much whatever we want...
```{r}
answer<-5+18

 answer

 y=10*4

y
```
We can also use our variables within other calculations or to define additional vartiables.
```{r}
 z=x*y

z
```
Note that "=" or "<-" assigns a particular value to a variable.  We can also ask R a question but we need slightly different notation for this.
Suppose we were interested in knowing whether our variable z was equal to x.  To do this we would use...
```{r}
z==x
```
The "==" asks the question "is z equal to x?". Here you can see that the answer is false.

NOTE THAT THIS IS VERY DIFFERENT FROM:
```{r}
z=x

#or z<-x, where here we have ASSIGNED z to be equal to x

z

x

z==x
```

## Adding Comments to R Code
You can see from some of my examples above that I sometimes added some notes or comments to my code.  Whenever I did this I always preceeded my comments with the # character.  This tells R that what follows the # is a comment and should be ignored.  Everything you write after the # will be ignored by R until you hit enter to begin another line of code.  At this point R will pay attention again.  
```{r}
#I want to add comments here.  This is OK.
```
If you forget to enter the # character before a comment then R will get very confused and give you an error because it doesn't understand what you mean.

# Working Directory
The working directory is the place on your computer where you are currently working. This is place where you R will ask for files that you request and where R will write output. You can see this in the 'Files' tab in the bottom right corner of RStudio, but you can also ask R for this information
```{r}
getwd()
```

You can see that I keep my R files oreganized within a series of folders for each project that I am working on.

## Setting the Working Directory
You can change your working directory in a few ways.  First, you can use the menus, but this is where Mac/Windows/Unix interfaces might differ.  On my Mac version of RStudio there is a menu "Session" and within this there is the option to "Set Working Directory".  This will open a browser where you can select your working directory.  Alternatively, you can use the command interface to do this directly. 

```{r}
setwd("/Users/andrewmcadam/Documents/McAdam/Research/R datafiles/IBIO-6000")
```
Note that R is case-sensitive so that Setwd and setwd are not equivalent!

