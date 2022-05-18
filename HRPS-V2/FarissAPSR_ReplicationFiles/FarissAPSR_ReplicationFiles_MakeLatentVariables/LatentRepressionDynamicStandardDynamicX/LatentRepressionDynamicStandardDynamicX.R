# set time start variable
systime1 <- Sys.time()
print(Sys.time() - systime1)

# load libraries
library(rjags); library(coda); library(foreign)

STARTYEAR <- 1949
#STARTYEAR <- 1956

#----------------------------------------------------------------------------------------------------#
# load and preprocess CIRI Physint data  1981-2010
ciri <- read.csv("CIRI_physint_data20120401.csv", na.strings=c(-999, -66, -77))
summary(ciri$YEAR)

#----------------------------------------------------------------------------------------------------#
# the CIRI data contains full country-year panels for several countries that the Correlates of War
# dataset code as single instances; therefore, the following code removes some redundant observations
# based on the duplicated numeric code from the correlates of war dataset
#----------------------------------------------------------------------------------------------------#
ciri$COW[ciri$CIRI==560] <- 345

# remove the following CIRI country-YEARs to conform with the correlates of war ccode for the inclusion of other datasets:
ciri <- subset(ciri, ciri$CIRI !=530 | ciri$YEAR>=1992) # removes Russia country-YEARs where the CIRI code=530 and where the YEAR<=1991; i.e., all other country-YEARs
ciri <- subset(ciri, ciri$CIRI !=590 | ciri$YEAR<=1991) # removes Soviet Union country-YEARs where the CIRI code=590 and where the YEAR>=1992; i.e., keeps all other country-YEARs
ciri <- subset(ciri, ciri$CIRI !=560 | ciri$YEAR>=2006) # removes Serbia country-YEARs where the CIRI code=689 and where the YEAR>=1992; i.e., keeps all other country-YEARs
ciri <- subset(ciri, ciri$CIRI !=458 | ciri$YEAR>=2006) # removes Montenagro country-YEARs where the CIRI code=689 and where the YEAR>=1992; i.e., keeps all other country-YEARs
ciri <- subset(ciri, ciri$CIRI !=689 | ciri$YEAR<=1991) # removes Yugoslavia country-YEARs where the CIRI code=689 and where the YEAR>=1992; i.e., keeps all other country-YEARs
ciri <- subset(ciri, ciri$CIRI !=563 | ciri$YEAR>=1992 & ciri$YEAR<=1999 | ciri$YEAR>=2003 & ciri$YEAR<=2005) # Serbia and Montenagro country-YEARs where the CIRI code=563 and YEAR <=1991 and YEAR >=20$
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

ciri <- subset(ciri, select=c(YEAR, CIRI, COW, DISAP, KILL, POLPRIS, TORT))
ciri <- subset(ciri, !is.na(DISAP) | !is.na(KILL) | !is.na(POLPRIS) | !is.na(TORT))


#----------------------------------------------------------------------------------------------------#
# load and preprocess PTS data
#pts <- read.csv("PTS2010.csv")
pts <- read.csv("PTS2011.csv")
pts <- subset(pts, select=c(Country, COW., Year, Amnesty, State.Dept.))
names(pts) <- c("Country", "COW", "YEAR", "Amnesty", "State")
pts <- subset(pts, YEAR < 2011)


pts$COW[pts$Country == "USSR"] <- 999
pts <- subset(pts, pts$COW !=365 | pts$YEAR>=1992)
pts <- subset(pts, pts$COW !=999 | pts$YEAR<=1991)
pts$COW[pts$Country == "USSR"] <- 365
pts$COW[pts$Country == "Serbia"] <- 999
pts <- subset(pts, pts$COW != 345 | pts$YEAR<=2006)
pts <- subset(pts, pts$COW != 999 | pts$YEAR>=2007)
pts$COW[pts$Country == "Serbia"] <- 345

pts <- subset(pts, !is.na(Amnesty) | !is.na(State), select=c(-Country))

# load Hathaway Torture data
# Note that 366, 367, 368, 370, 371, 373 have expanded coverage in the Hathaway dataset
hathaway <- read.csv("Hathaway2002longData.csv")
hathaway <- subset(hathaway, select=c(ccode, year, torture))
names(hathaway) <-  c("COW", "YEAR", "hathaway")
nrow(hathaway)
hathaway <- na.omit(hathaway) # remove some NAs because of state existence issue with wide format conversion
nrow(hathaway)


# load Conrad and Moore Ill Treatment and Torture data
ITT <- read.csv("ITT_CY.csv", na.strings=c("-999", "-888", "-777"))

ITT$cowccode[ITT$cowccode==340] <- 345
ITT$cowccode[ITT$cowccode==678] <- 679
ITT$cowccode[ITT$cowccode==665] <- 666

ITT$scale <- NA
ITT$scale[as.character(ITT$LoT) == "No Allegations"] <- 1
ITT$scale[as.character(ITT$LoT) == "Infrequent"] <- 2
ITT$scale[as.character(ITT$LoT) == "Several"] <- 3
ITT$scale[as.character(ITT$LoT) == "Routinely"] <- 4
ITT$scale[as.character(ITT$LoT) == "Widespread"] <- 5
ITT$scale[as.character(ITT$LoT) == "Systematic"] <- 6

ITT$restricted <- NA
ITT$restricted[as.character(ITT$RstrctAccess) == "No"] <- 0
ITT$restricted[as.character(ITT$RstrctAccess) == "Yes"] <- 1

ITT <- subset(ITT, select=c(year, cowccode, scale, restricted))
names(ITT) <- c("YEAR", "COW", "ITT", "ITTrestricted")


# load genocide/politicide data
# genocide <- read.csv("Genocide_Politicide_panel2009.csv")
genocide <- read.csv("Genocide_Politicide_panel2010.csv")
#genocide <- subset(genocide, select=c(ccode, year, Mgenocide))
#names(genocide) <- c("COW", "YEAR", "Mgenocide")
genocide <- subset(genocide, select=c(ccode, year, genocide))
names(genocide) <- c("COW", "YEAR", "genocide")

# load Rummel's democide data
rummel <- read.csv("Rummel_Politicide_panel1987.csv")
rummel <- subset(rummel, year>=STARTYEAR)
names(rummel) <- c("COW", "YEAR", "rummel")

# government killing
#killing <- read.csv("OneSidedKilling1989_2010.csv")
killing <- read.csv("OneSidedKilling1989_2011.csv")
killing <- subset(killing, select=c(ccode, YEAR))
killing <- subset(killing, YEAR < 2011)
names(killing) <- c("COW", "YEAR")
killing$killing <- 1 

# whpsi government execusion
whpsi <- read.csv("whpsi.csv")
whpsi$executions <- 0
whpsi$executions[whpsi$POLITICAL.EXECUTION>0] <- 1
whpsi <- subset(whpsi, YEAR>=STARTYEAR, select=c(COW, YEAR, executions))

# Harff and Gurr Massive repression data
massive <- read.csv("Massive_State_Repression_Panel_1988.csv")
massive <- subset(massive, year>=STARTYEAR)
names(massive) <- c("COW", "YEAR", "massive_repression")

#----------------------------------------------------------------------------------------------------#
# merge data
#----------------------------------------------------------------------------------------------------#
data <- merge(genocide, ciri, by.x=c("COW", "YEAR"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=FALSE)
nrow(data)
data <- merge(data, pts, by.x=c("COW", "YEAR"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=TRUE)
nrow(data)
data <- merge(data, hathaway, by.x=c("COW", "YEAR"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=TRUE)
nrow(data)
data <- merge(data, ITT, by.x=c("COW", "YEAR"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=TRUE)
nrow(data)
data <- merge(data, rummel, by.x=c("COW", "YEAR"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=TRUE)
nrow(data)
data <- merge(data, killing, by.x=c("COW", "YEAR"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=TRUE)
nrow(data)
data <- merge(data, whpsi, by.x=c("COW", "YEAR"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=TRUE)
nrow(data)
data <- merge(data, massive, by.x=c("COW", "YEAR"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=TRUE)
nrow(data)

data <- subset(data, select=c(YEAR, CIRI, COW, DISAP, KILL, POLPRIS, TORT, Amnesty, State, hathaway, ITT, genocide, rummel, massive_repression, executions, killing))

data$genocide[is.na(data$genocide) & data$YEAR>=1956] <- 0
data$rummel[is.na(data$rummel) & data$YEAR<=1987] <- 0
data$massive_repression[is.na(data$massive_repression) & data$YEAR<=1988] <- 0
data$killing[is.na(data$killing) & data$YEAR>=1989] <- 0

data$genocide[data$COW==666.001] <- NA
data$rummel[data$COW==666.001] <- NA
data$killing[data$COW==666.001] <- NA
data$massive_repression[data$COW==666.001] <- NA
data$genocide[data$COW==666.002] <- NA
data$rummel[data$COW==666.002] <- NA
data$killing[data$COW==666.002] <- NA
data$massive_repression[data$COW==666.002] <- NA
data$genocide[data$COW==666.003] <- NA
data$rummel[data$COW==666.003] <- NA
data$killing[data$COW==666.003] <- NA
data$massive_repression[data$COW==666.003] <- NA

#data <- na.omit(data)
# don't include !is.na(genocide) you predefined it to have full coverage but its okay now because it adds 3 values which have 2 or more items in the lag and lead year
data <- subset(data, !is.na(DISAP) | !is.na(KILL) | !is.na(POLPRIS) | !is.na(TORT) | !is.na(Amnesty) | !is.na(State) | !is.na(hathaway) | !is.na(ITT) | !is.na(genocide) | !is.na(rummel) | !is.na(massive_repression) | !is.na(killing) | !is.na(executions))
nrow(data)
n <- nrow(data)


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

# full model (13 items)
y.pre <- as.matrix(data[,4:16])
y <- matrix(data=NA, ncol=ncol(y.pre), nrow=nrow(y.pre))
for(i in 1:nrow(y.pre)){
  for(j in 1:4){
    y[i, j] <- as.numeric(y.pre[i, j]) + 1
  }
  for(j in 5:8){
    y[i, j] <- as.numeric(y.pre[i, j])
  }
  for(j in 9:13){
    y[i, j] <- as.numeric(y.pre[i, j])  
  }
}


head(y)
time <- data$YEAR - STARTYEAR + 1


# random initial values
MakeInits <- function(){
  nIRT.Binary <- 5
  nIRT.Ordered3 <- 4; Cuts3 <- 2
  nIRT.Ordered5 <- 3; Cuts5 <- 4
  nIRT.Ordered6 <- 1; Cuts6 <- 5
  
  MU <- matrix(rnorm(length(panel)*max(panel), mean = 0, sd = 1), nrow=length(panel),  ncol=max(panel))

  BETA1 <- runif(nIRT.Binary)
  ALPHA1 <- runif(nIRT.Binary)

  BETA3 <- runif(nIRT.Ordered3)
  ALPHA03 <- array(c(runif(nIRT.Ordered3, 0, 1),
                     runif(nIRT.Ordered3, 1, 2)), dim=c(nIRT.Ordered3, Cuts3, max(year)))

  BETA5 <- runif(nIRT.Ordered5)
  ALPHA05 <- array(c(runif(nIRT.Ordered5, 0.0, 0.5),
                      runif(nIRT.Ordered5, 0.5, 1.0),
                      runif(nIRT.Ordered5, 1.0, 1.5),
                      runif(nIRT.Ordered5, 1.5, 2.0)), dim=c(nIRT.Ordered5, Cuts5,  max(year)))

   BETA6 <- runif(nIRT.Ordered6)
  ALPHA06 <- array(c(runif(nIRT.Ordered6, 0.0, 0.5),
                      runif(nIRT.Ordered6, 0.5, 1.0),
                      runif(nIRT.Ordered6, 1.0, 1.5),
                      runif(nIRT.Ordered6, 1.5, 2.0),
                      runif(nIRT.Ordered6, 2.0, 2.5)), dim=c(nIRT.Ordered6, Cuts6,  max(year)))
  
  SIGMA <- runif(1)

  out <- list(mu=MU, alpha1=ALPHA1, alpha03=ALPHA03, alpha05=ALPHA05,  alpha06=ALPHA06, beta1=BETA1, beta3=BETA3, beta5=BETA5, beta6=BETA6, sigma=SIGMA)
  return(out)
}
inits1 <- MakeInits()
inits2 <- MakeInits()
inits3 <- MakeInits()

inits.function <- function(chain){
  return(switch(chain,
         "1"=inits1,
         "2"=inits2,
         "3"=inits3
         ))
}

# jags.model arguments
ADAPT <- 1000
BURNIN <- 50000
DRAWS <- 250000
THIN <- 10
CHAINS <- 2

NAME <- "LatentRepressionDynamicStandardDynamicX.bug"

# print time taken
print(Sys.time() - systime1)
  
#rjags code version
m <- jags.model(file=NAME, data=list("y"=y, "time"=time, "year"=year, "country"=country, "n.country"=length(panel), "n.year"=max(panel), "n"=nrow(y)), inits=inits.function, n.chains=CHAINS, n.adapt=ADAPT)

print(Sys.time() - systime1)

update(m, BURNIN)
print(Sys.time() - systime1)


systime1 <- Sys.time()

j <- dic.samples(m, n.iter=DRAWS, thin=THIN, type="pD")
j

save.image(file="image.Rdata")

M <- coda.samples(m, variable.names=c("x", "beta1", "beta3", "beta5", "beta6", "alpha1", "alpha3", "alpha5", "alpha6", "kappa", "sigma"), n.iter=DRAWS, progress.bar="text", thin=THIN)


save.image(file="image.Rdata")


print(Sys.time() - systime1)



mat1 <- as.matrix(as.mcmc(M[[1]]))
mat2 <- as.matrix(as.mcmc(M[[2]]))
posterior.estimates <- rbind(mat1, mat2)
#write.csv(as.data.frame(mat1), "EstimateDynamicStandardDynamicX_YSTAR.csv", row.names=F)
write.csv(as.data.frame(posterior.estimates), "EstimateDynamicStandardDynamicX.csv", row.names=F)

save.image(file="image.Rdata")


# YSTAR

NAME <- "LatentRepressionDynamicStandardDynamicX_YSTAR.bug"

#rjags code version
m <- jags.model(file=NAME, data=list("y"=y, "time"=time, "year"=year, "country"=country, "n.country"=length(panel), "n.year"=max(panel), "n"=nrow(y)), inits=inits.function, n.chains=CHAINS, n.adapt=ADAPT)

print(Sys.time() - systime1)

update(m, BURNIN)
print(Sys.time() - systime1)


systime1 <- Sys.time()

DRAWS <- 20000
#DRAWS <- 2000
# take posterior draws
systime1 <- Sys.time()
print(Sys.time() - systime1)


M <- coda.samples(m, variable.names=c("ystar"), n.iter=DRAWS, progress.bar="text", thin=THIN)

print(Sys.time() - systime1)



mat1 <- as.matrix(as.mcmc(M[[1]]))
mat2 <- as.matrix(as.mcmc(M[[2]]))
posterior.estimates <- rbind(mat1, mat2)
write.csv(as.data.frame(mat1), "EstimateConstantStandardDynamicX_YSTAR.csv", row.names=F)

save.image(file="image.Rdata")

