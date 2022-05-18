## ---------------------------------------------------------------------- #
##
## Christopher J. Fariss
## "Yes, Human Rights Practices Are Improving Over Time"
## American Political Science Review
##
## Special thanks to Kevin Reuning for helping with these files
## R code is modified from new code that is part of a joint project:
## Reuning, Kevin, Michael R. Kenwick, and Christopher J. Fariss.
## "Exploring the Dynamics of Latent Variable Models"
## Political Analysis
## ---------------------------------------------------------------------- #

args <- commandArgs(trailingOnly = T)
if(length(args)!=1){
  stop("Must give args: RScript.exe HPC.R --args 'id'")
} else {
  select <- as.numeric(args[1])
}
# 
# setwd("D:/Dropbox/Projects/HR_Validation")
#setwd("/home/kreuning/validation")
# setwd("~/HR_Validation")
.libPaths("~/.Rlibs")

#### rstan version 2.15.1
#### R version 3.3.1
library(rstan)
library(MASS)
library(rms)
# library(loo)
load("Stan_Data_Prepped.RData")

values <- read.csv("control_values_2.csv", stringsAsFactors = F)


model <- "Stan_Models/M_Fixed.stan"


model <- readLines(model)

tmp.df <- read.csv("Stan_Models/Drops_Fixed_No_Events.csv")
rownames(tmp.df) <- tmp.df$Var
tmp.df$Var <- NULL

if(select > nrow(tmp.df)){
  drop <- as.numeric(unlist(tmp.df))
  drop <- drop[!is.na(drop)]
  model <- model[-drop]
} else {
  drop <- as.numeric(unlist(tmp.df[(-1:(-select)), ]))
  drop <- drop[!is.na(drop)]
  model <- model[-drop]
}



mod <- stan(model_code=model, data=stan.data, iter=2000,
            chains=4,
            cores = 1, verbose=F, pars="theta_raw", include = F, thin=4,
            seed = 61717, control=list(max_treedepth=15))


if(select > nrow(tmp.df)){
  write.csv(summary(mod)$summary, file=paste("out/progressive_no_events_summary_", "events", ".csv", sep=""))
  save.image(file=paste("out/progressive_no_events_summary_", "events", ".RData", sep=""))
  
} else {
  write.csv(summary(mod)$summary, file=paste("out/progressive_no_events_summary_", rownames(tmp.df)[select], ".csv", sep=""))
  save.image(file=paste("out/progressive_no_events_summary_", rownames(tmp.df)[select], ".RData", sep=""))
  
}

q()
