# ---------------------------------------------------------------------------------------------------- #
# FarissAPSR_ReplicationFiles.txt
# ---------------------------------------------------------------------------------------------------- #

 Date: 2014-05-14

 Authors: Christopher Fariss

 Title: Respect for Human Rights has Improved Over Time: Modeling the Changing Standard of Accountability
 
 Journal: American Political Science Review 108(2):TBD (May 2014). 
 
 Available at: http://ssrn.com/abstract=2358014.

 Appendix: http://cfariss.com/documents/Fariss2014APSR_SupplementaryAppendix.pdf

 Contact: 
 Chris Fariss: cjf0006@gmail.com

 Copyright (c) 2014, under the Creative Commons Attribution-Noncommercial-Share Alike 3.0 United States License.
 For more information see: http://creativecommons.org/licenses/by-nc-sa/3.0/us/
 All rights reserved. 

 Data from this project is publicly available here: http://cfariss.com

 Note that the MCMC simulations take several days to finish on a server. We do not recommend running the code
 on a laptop or desktop. Please let us know if you have any questions about the code. 

# ---------------------------------------------------------------------------------------------------- #
# file folder contents
# ---------------------------------------------------------------------------------------------------- #
Each file folder contains data, R code, and JAGS model files necessary to estimate the latent variables from the main article and several alternative versions mentioned in the appendix. 
 
	LatentRepressionConstantStandardDynamicX --- estimate the latent variable that assumes a constant standard of accountability 	LatentRepressionDynamicStandardDynamicX --- estimate the latent variable that assumes a dynamic or changing standard of accountability	LatentRepressionDynamicStandardDynamicX_EXTENSTIONS --- estimate several alternative latent variables 

# ---------------------------------------------------------------------------------------------------- #
# install R and necessary packages for analysis
# ---------------------------------------------------------------------------------------------------- #

Note that the .Rdata files, once generated, must be loaded into R.

open the .R file using any text or source code editor such as:
	TextEdit, emacs, Aquamacs, notepad++ , or Xpad

set the working directory to the folder containing the data files 

the set working directory command in R is setwd()
	type ?setwd for help documentation 

to set the path type into R: 

setwd("PATH_NAME")

where PATH_NAME is the path to the folder with the data

Install Bayesian packages if necessary
Install JAGS to system before installing the rjags or R2jags packages in R

	install.packages("rjags")
	install.packages("R2jags")
	install.packages("coda")
	

# ---------------------------------------------------------------------------------------------------- #
# end file
# ---------------------------------------------------------------------------------------------------- #

