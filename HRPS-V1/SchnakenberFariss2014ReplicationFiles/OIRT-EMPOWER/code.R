#----------------------------------------------------------------------------------------------------#
rm(list = ls())

library(R2jags)
library(rjags)
library(foreign)


#----------------------------------------------------------------------------------------------------#
# CIRI Empowerment data  2007-2009
#ciri <- read.csv("CIRI_empowerment_data20101123.csv", na.strings=c(-999, -66, -77))
#year.start <- 2007

# CIRI Empowerment data  1981-2010
ciri <- read.csv("../data/CIRI_empowerment_data20120410.csv", na.strings=c(-999, -66, -77))
year.start <- 1981

#----------------------------------------------------------------------------------------------------#
# the CIRI data contains full country-year panels for several countries that the Correlates of War 
# dataset code as single instances; therefore, the following code removes some redundant observations 
# based on the duplicated numeric code from the correlates of war dataset
#----------------------------------------------------------------------------------------------------#
#
# remove the following CIRI country-YEARs to conform with the correlates of war ccode for the inclusion of other datasets:
ciri <- subset(ciri, ciri$CIRI !=530 | ciri$YEAR>=1992) # removes Russia country-YEARs where the CIRI code=530 and where the YEAR<=1991; i.e., all other country-YEARs
ciri <- subset(ciri, ciri$CIRI !=590 | ciri$YEAR<=1991) # removes Soviet Union country-YEARs where the CIRI code=590 and where the YEAR>=1992; i.e., keeps all other country-YEARs
ciri <- subset(ciri, ciri$CIRI !=560 | ciri$YEAR>=2006) # removes Serbia country-YEARs where the CIRI code=689 and where the YEAR>=1992; i.e., keeps all other country-YEARs
ciri <- subset(ciri, ciri$CIRI !=458 | ciri$YEAR>=2006) # removes Montenagro country-YEARs where the CIRI code=689 and where the YEAR>=1992; i.e., keeps all other country-YEARs
ciri <- subset(ciri, ciri$CIRI !=689 | ciri$YEAR<=1991) # removes Yugoslavia country-YEARs where the CIRI code=689 and where the YEAR>=1992; i.e., keeps all other country-YEARs
ciri <- subset(ciri, ciri$CIRI !=563 | ciri$YEAR>=1992 & ciri$YEAR<=1999 | ciri$YEAR>=2003 & ciri$YEAR<=2006) # Serbia and Montenagro country-YEARs where the CIRI code=563 and YEAR <=1991 and YEAR >=2000 and YEAR <=2002 and YEAR >= 2006
ciri <- subset(ciri, ciri$CIRI !=692 | ciri$YEAR>=2000 & ciri$YEAR<=2002) # Yugoslavia, Federal Republic country-YEARs where the CIRI code=692 and where YEAR<=1999 and YEAR>=2003


# add the following correlates of war ccodes for the inclusion of other datasets:
n <- nrow(ciri)
t <- 1
p <- 1

while(t <= n){
  if(ciri$CIRI[t]==458 && ciri$YEAR[t]>=2006)
  {ciri$COW[t] <- 341
  t <- t + 1}
  else if(ciri$CIRI[t]==560 && ciri$YEAR[t]>=2006)
  {ciri$COW[t] <-345
  t <- t + 1} 
  else if(ciri$CIRI[t]==563 && ciri$YEAR[t]==2005)
  {ciri$COW[t] <-345
  t <- t + 1} 
  else
  t <- t + 1
}

rm(t)
rm(p)
#----------------------------------------------------------------------------------------------------#


#----------------------------------------------------------------------------------------------------#
#ASSN FORMOV DOMMOV SPEECH ELECSD NEW_RELFRE WORKER
#----------------------------------------------------------------------------------------------------#
data <- ciri
rm(ciri)

#data <- na.omit(subset(data, select=c(CTRY, YEAR, CIRI, COW, ASSN, FORMOV, DOMMOV, SPEECH, ELECSD, NEW_RELFRE, WORKER))) 
data <- subset(data, !is.na(ASSN) | !is.na(ASSN) | !is.na(FORMOV) | !is.na(DOMMOV) | !is.na(SPEECH) | !is.na(ELECSD) | !is.na(NEW_RELFRE) | !is.na(WORKER))
n <- nrow(data)
n

data <- subset(data, !is.na(data$COW))
n <- nrow(data)
n

summary(data)


year <- NA
year[1] <- 1 
country <- NA
panel <- NA
panel.count <-1
i <- 2
country[1] <- 1
j <- 1
while(i <= nrow(data)){
if(data$COW[i]!=data$COW[i-1]){
panel[j] <- panel.count
panel.count <- 0
j <- j+1
}
country[i] <- j
#i <- i + 1
panel.count <- panel.count + 1
year[i] <- panel.count
i <- i + 1
}
j
panel[j] <- panel.count

year

#country
#country <- unique(country)
#country
#panel.count
#panel
#N_panel <- length(panel)
#N_panel

# full model (7 items)
y.pre <- as.matrix(data[,c(5, 6, 7, 8, 9, 10, 11)])
y <- matrix(data=NA, ncol=ncol(y.pre), nrow=nrow(y.pre))
for(i in 1:nrow(y.pre)){
  for(j in 1:7){
    y[i, j] <- as.numeric(y.pre[i, j]) + 1
  }
}

dump("country", "../alldraws/oirtempower-country.R")
dump("year", "../alldraws/oirtempower-year.R")


inits.function <- function(chain){
  return(switch(chain,
         "1"=list(mu=matrix(rnorm(length(panel)*max(panel), mean = 0, sd = 1), nrow=length(panel),  ncol=max(panel)), beta=runif(7), alpha0=matrix(c(runif(7), runif(7, 1, 2)), nrow=7, ncol=2, byrow=TRUE)),
         "2"=list(mu=matrix(rnorm(length(panel)*max(panel), mean = 0, sd = 1), nrow=length(panel),  ncol=max(panel)), beta=runif(7), alpha0=matrix(c(runif(7), runif(7, 1, 2)), nrow=7, ncol=2, byrow=TRUE)),
         "3"=list(mu=matrix(rnorm(length(panel)*max(panel), mean = 0, sd = 1), nrow=length(panel),  ncol=max(panel)), beta=runif(7), alpha0=matrix(c(runif(7), runif(7, 1, 2)), nrow=7, ncol=2, byrow=TRUE))))
}
#source("draws1.R")
#source("draws2.R")
#source("draws3.R")

inits <- function(chain){
   return(switch(chain,
      "1"=last1,
      "2"=last2,
      "3"=last3))
}

ADAPT <- 1000
BURNIN <- 50000
DRAWS <- 250000
THIN <- 25

# change inits to inits.function and run 3 chains to run from scratch
#rjags code version
m <- jags.model(file="model.bug", data=list("y"=y, "year"=year, "country"=country, "n.country"=length(panel), "n.year"=max(panel), 
"n"=nrow(y)), inits=inits.function, n.chains=3, n.adapt=ADAPT)
update(m, BURNIN)
M <- coda.samples(m, variable.names=c("x", "beta", "alpha"), n.iter=DRAWS, progress.bar="text", thin=THIN)

save.image(file="mywork.Rdata")

# check for convergence
grs <- gelman.diag(M)
geweke <- geweke.diag(M)
heidel <- heidel.diag(M)

save.image(file="mywork.Rdata")
 
j <- dic.samples(m, n.iter=DRAWS, thin=THIN, type="pD")
j

save.image(file="mywork.Rdata")


# compute parameter estimates from the mcmc chains
mat1 <- as.matrix(M[[1]])
mat2 <- as.matrix(M[[2]])
mat3 <- as.matrix(M[[3]])
posterior.estimates <- rbind(mat1, mat2, mat3)
vars <- t(as.matrix(posterior.estimates))
parameter.mean <- apply(vars, 1, mean)
parameter.median <- apply(vars, 1, median)
parameter.sd <- apply(vars, 1, sd)
parameter.lower.ci <- apply(vars, 1, quantile, c(0.025))
parameter.upper.ci <- apply(vars, 1, quantile, c(0.975))
   
save.image(file="mywork.Rdata")
     
 

