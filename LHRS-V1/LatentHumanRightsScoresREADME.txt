# ---------------------------------------------------------------------------------------------------- #
# LatentHumanRightsScoresREADME.txt
# ---------------------------------------------------------------------------------------------------- #

 Date: 2012-08-02

 Authors: Keith Schnakenberg and Christopher Fariss

 Title: Dynamic Patterns of Human Rights Practices. 
 Available at: http://ssrn.com/abstract=1534335.

 Contact: 
 Chris Fariss: cjf0006@gmail.com
 Keith Schnakenberg: keschnak@wustl.edu

 Copyright (c) 2012, under the Creative Commons Attribution-Noncommercial-Share Alike 3.0 United States License.
 For more information see: http://creativecommons.org/licenses/by-nc-sa/3.0/us/
 All rights reserved. 

 Note that the .Rdata files are very large. You only need to load these if you would like to examine 
 a subset of the original draws from the posterior distribution. Otherwise the .csv file is much easier
 to work with. Below is example code, which demonstrates how to take draws from the distribution for 
 each latent variable estimate. Please e-mail us if you have any questions on how to use these data.


# ---------------------------------------------------------------------------------------------------- #
# loading the files to analyze the latent physical integrity estimates 
# ---------------------------------------------------------------------------------------------------- #

DOIRT_5000_PhysintLatentVariableEsimates_1981_2010.RdataDOIRT_EmpowermentLatentVariableEsimates_1981_2010.csv


# ---------------------------------------------------------------------------------------------------- #
# loading the files to analyze the latent empowerment estimates 
# ---------------------------------------------------------------------------------------------------- #

DOIRT_5000_EmpowermentLatentVariableEsimates_1981_2010.RdataDOIRT_PhysintLatentVariableEsimates_1981_2010.csv


# ---------------------------------------------------------------------------------------------------- #
# install R and necessary packages for analysis
# ---------------------------------------------------------------------------------------------------- #

Note that the .Rdata files must be loaded into R.

open the .R file using any text or source code editor such as:
	TextEdit, emacs, Aquamacs, notepad++ , or Xpad

set the working directory to the folder containing the data files 

the set working directory command in R is setwd()
	type ?setwd for help documentation 

to set the path type into R: 

setwd("PATH_NAME")

where PATH_NAME is the path to the folder with the data


# ---------------------------------------------------------------------------------------------------- #
# example analysis of one country year
# Guatemala 1984
# ---------------------------------------------------------------------------------------------------- #

# hard code data into Rscript for demonstration purposes
# normally just load the data file using read.csv() for the .csv files or load() for the .Rdata files
latentmean <- -1.8269471
latentsd <- 0.2487799


# take 1000 draws from a normal distribution for the country year
draws  <- rnorm(1000, mean=latentmean, sd=latentsd)


# calculate some quantities of interest 
mean(draws)
median(draws)
quantile(draws)

# calculate 95% credible intervals
quantile(draws, c(.025, .975))


# ---------------------------------------------------------------------------------------------------- #
# end file
# ---------------------------------------------------------------------------------------------------- #

