###########################################
## Prepare the data for STAN model fit
## loads and merges all constituent datasets
## currently updated through 2021 data releases where available
###########################################

# use
#### Update new data

id.func <- function(id, n){
  tmp <- rep(1, n)
  if(id!=1){
    for(ii in 2:id){
      tmp <- append(tmp, rep(ii, n))
    }
  }
  tmp
}

# set time start variable
systime1 <- Sys.time()
print(Sys.time() - systime1)

# load libraries
#library(rjags); library(coda); library(foreign)
#.libPaths( c( .libPaths(), "/usr/lib64/R/library") )




#STARTYEAR <- 1945
STARTYEAR <- 1946
#STARTYEAR <- 1949
#STARTYEAR <- 1956

#----------------------------------------------------------------------------------------------------#
# load and preprocess CIRI Physint data  1981-2010
#ciri <- read.csv("LHRS-V4/data_raw/CIRI_physint_data20120401.csv", na.strings=c(-999, -66, -77))
# load and preprocess CIRI Physint data  1981-2011
ciri <- read.csv("LHRS-V4/data_raw/CIRI_physint2011.csv", na.strings=c(-999, -66, -77))
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

ciri <- subset(ciri, select=c(YEAR, CIRI, COW, DISAP, KILL, TORT, POLPRIS))
ciri <- subset(ciri, !is.na(DISAP) | !is.na(KILL) | !is.na(TORT) | !is.na(POLPRIS))


#----------------------------------------------------------------------------------------------------#
# load and preprocess PTS data
#pts <- read.csv("LHRS-V4/data_raw/PTS2010.csv")
#pts <- read.csv("LHRS-V4/data_raw/PTS2011.csv")
#pts <- subset(pts, select=c(Country, COW., Year, Amnesty, State.Dept.))
#pts <- read.csv("LHRS-V4/data_raw/PTS2013.csv")
#pts <- read.csv("LHRS-V4/data_raw/PTS2014.csv") # values thourhg 2013 (2014 report/publication year)
#pts <- subset(pts, select=c(Country, COWnum, Year, Amnesty, StateDept, HRW))
#pts <- read.csv("LHRS-V4/data_raw/PTS2015.csv") # values through 2014 (2015 report/publication year)

# Country Country_OLD Year COW_Code_A COW_Code_N WordBank_Code_A UN_Code_N Region PTS_A PTS_H PTS_S
#pts <- read.csv("LHRS-V4/data_raw/PTS2016.csv") # values through 2016 (2017 report/publication year)
#pts <- read.csv("LHRS-V4/data_raw/PTS2017.csv") # values through 2017 (2018 report/publication year)
#pts <- read.csv("LHRS-V4/data_raw/PTS2018.csv")  # values through 2018 (2019 report/publication year)
#pts <- read.csv("LHRS-V4/data_raw/PTS-2020.csv") # values through 2019 (2020 report/publication year)
#pts <- read.csv("LHRS-V4/data_raw/PTS-2021.csv") # values through 2020 (2021 report/publication year)
pts <- read.csv("LHRS-V4/data_raw/PTS-2022.csv") # values through 2021 (2022 report/publication year)
pts <- subset(pts, select=c(Country, COW_Code_N, Year, PTS_A, PTS_S, PTS_H))
head(pts)
names(pts) <- c("Country", "COW", "YEAR", "Amnesty", "State", "HRW")


pts$COW[pts$Country == "USSR"] <- 999
pts <- subset(pts, pts$COW !=365 | pts$YEAR>=1992)
pts <- subset(pts, pts$COW !=999 | pts$YEAR<=1991)
pts$COW[pts$Country == "USSR"] <- 365
pts$COW[pts$Country == "Serbia"] <- 999
pts <- subset(pts, pts$COW != 345 | pts$YEAR<=2006)
pts <- subset(pts, pts$COW != 999 | pts$YEAR>=2007)
pts$COW[pts$Country == "Serbia"] <- 345
dim(pts)
pts$COW[pts$Country == "Yugoslavia, Socialist Federal Republic of" & pts$YEAR==1991] <- 999
pts$COW[pts$Country == "Yugoslavia, Socialist Federal Republic of" & pts$YEAR==1992] <- 999
pts <- subset(pts, pts$COW != 999 )
dim(pts)


pts <- subset(pts, !is.na(Amnesty) | !is.na(State) | !is.na(HRW), select=c(-Country))
dim(pts)


# load Hathaway Torture data
# Note that 366, 367, 368, 370, 371, 373 have expanded coverage in the Hathaway dataset
hathaway <- read.csv("LHRS-V4/data_raw/Hathaway2002longData.csv")
hathaway <- subset(hathaway, select=c(ccode, year, torture))
names(hathaway) <-  c("COW", "YEAR", "hathaway")
nrow(hathaway)
hathaway <- na.omit(hathaway) # remove some NAs because of state existence issue with wide format conversion
nrow(hathaway)


# load Conrad and Moore Ill Treatment and Torture data
ITT <- read.csv("LHRS-V4/data_raw/ITT_CY.csv", na.strings=c("-999", "-888", "-777"))

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
# genocide <- read.csv("LHRS-V4/data_raw/Genocide_Politicide_panel2009.csv")
#genocide <- read.csv("LHRS-V4/data_raw/Genocide_Politicide_panel2010.csv")
#genocide <- subset(genocide, select=c(ccode, year, Mgenocide))
#names(genocide) <- c("COW", "YEAR", "Mgenocide")
#genocide <- read.csv("LHRS-V4/data_raw/Genocide_Politicide_panel2013.csv")
#genocide <- read.csv("LHRS-V4/data_raw/Genocide_Politicide_panel2014.csv")
#genocide <- read.csv("LHRS-V4/data_raw/Genocide_Politicide_panel2015.csv")
#genocide <- read.csv("LHRS-V4/data_raw/Genocide_Politicide_panel2017.csv")
genocide <- read.csv("LHRS-V4/data_raw/Genocide_Politicide_panel2018.csv")
genocide <- subset(genocide, select=c(ccode, year, genocide))
names(genocide) <- c("COW", "YEAR", "genocide")

# load Rummel's democide data
rummel <- read.csv("LHRS-V4/data_raw/Rummel_Politicide_panel1987.csv")
rummel <- subset(rummel, year>=STARTYEAR)
names(rummel) <- c("COW", "YEAR", "rummel")

# government killing
#killing <- read.csv("LHRS-V4/data_raw/OneSidedKilling1989_2010.csv")
#killing <- read.csv("LHRS-V4/data_raw/OneSidedKilling1989_2011.csv")
#killing <- subset(killing, select=c(ccode, YEAR))
#killing <- read.csv("LHRS-V4/data_raw/OneSidedKilling1989_2013.csv")
#killing <- read.csv("LHRS-V4/data_raw/OneSidedKilling1989_2014.csv")
#killing <- subset(killing, select=c(ccode, Year))
#names(killing) <- c("COW", "YEAR")
#killing <- read.csv("LHRS-V4/data_raw/ucdp-onesided-14-2016.csv")
## selects columns and drops non-state actors
#killing <- subset(killing, IsGovernmentActor==1, select=c(ActorId, Year, BestFatalityEstimate, LowFatalityEstimate, HighFatalityEstimate))
#killing <- read.csv("LHRS-V4/data_raw/ucdp-onesided-181-2017.csv")
#killing <- subset(killing, is_government_actor==1, select=c(gwno_a, year, best_fatality_estimate, low_fatality_estimate, high_fatality_estimate))
#names(killing) <- c("COW", "YEAR", "killing_best", "killing_low", "killing_high")

#killing <- read.csv("LHRS-V4/data_raw/ucdp-onesided-201-2019.csv")
#killing <- read.csv("LHRS-V4/data_raw/ucdp-onesided-211-2020.csv")
killing <- read.csv("LHRS-V4/data_raw/ucdp-onesided-221-2021.csv")
## selects columns and drops non-state actors
killing <- subset(killing, is_government_actor==1, select=c(gwnoa, year, best_fatality_estimate, low_fatality_estimate, high_fatality_estimate))
names(killing) <- c("COW", "YEAR", "killing_best", "killing_low", "killing_high")



# fix North Yemen to Yemen COW code
killing$COW[killing$COW==678] <- 679
#killing$killing <- 1

killing <- subset(killing, !is.na(COW))

# whpsi government execution
whpsi <- read.csv("LHRS-V4/data_raw/whpsi.csv")
whpsi$executions <- 0
whpsi$executions[whpsi$POLITICAL.EXECUTION>0] <- 1
whpsi$negative_sanctions <- 0
whpsi$negative_sanctions[whpsi$IMPOSITION.OF.POL.SANCT>0] <- 1
whpsi <- subset(whpsi, YEAR>=STARTYEAR, select=c(COW, YEAR, executions, negative_sanctions))

# Harff and Gurr Massive repression data
massive <- read.csv("LHRS-V4/data_raw/Massive_State_Repression_Panel_1988.csv")
massive <- subset(massive, year>=STARTYEAR)
names(massive) <- c("COW", "YEAR", "massive_repression")

# state led massive repression
#mass_killing <- read.csv("LHRS-V4/data_raw/mkl_ccode_2014.csv")
#mass_killing <- read.csv("LHRS-V4/data_raw/mkl_ccode_2015.csv")
mass_killing <- read.csv("LHRS-V4/data_raw/mkl_ccode_2015.csv")
mass_killing <- subset(mass_killing, year>=STARTYEAR, select=c(ccode, year, mkl.ongoing))
names(mass_killing) <- c("COW", "YEAR", "mass_killing")


## pitf <- read.csv("pitf_ccode_2015.csv")

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
data <- merge(data, mass_killing, by.x=c("COW", "YEAR"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=TRUE)
nrow(data)
# data <- merge(data, pitf, by.x=c("COW", "YEAR"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=TRUE)
# nrow(data)

data <- subset(data, select=c(YEAR, CIRI, COW, DISAP, KILL, POLPRIS, TORT, Amnesty, 
                              State, HRW, hathaway, ITT, genocide, rummel,
                              massive_repression, executions, negative_sanctions, 
                              mass_killing, killing_low, killing_best, killing_high))
# pitf_low_killing, pitf_high_killing))

nrow(data)

# join Czech and Czechoslovakia (its Czechia now!!!)
data$Amnesty[data$COW==315 & data$YEAR==1992] <- data$Amnesty[data$COW==316 & data$YEAR==1992]
data$State[data$COW==315 & data$YEAR==1992] <- data$State[data$COW==316 & data$YEAR==1992]
data <- subset(data, COW!=316 | YEAR!=1992)
data$COW[data$COW==315] <- 316
nrow(data)

data$genocide[is.na(data$genocide) & data$YEAR>=1956 & data$YEAR<=2018] <- 0
data$rummel[is.na(data$rummel) & data$YEAR>=1949 & data$YEAR<=1987] <- 0
data$massive_repression[is.na(data$massive_repression) & data$YEAR>=1945 & data$YEAR<=1988] <- 0


###### Fixing PITF and UCDP low
data$killing_low[is.na(data$killing_low) & data$YEAR>=1989 & data$YEAR<=2021] <- 0

# selec <- is.na(data$killing_low) & is.na(data$pitf_low_killing) & data$YEAR>=1995 & data$YEAR<=2015
# data$killing_low[selec] <- 0
# data$pitf_low_killing[selec] <- 0


### translate the killing_low variable to a binary variable (for earlier models)
data$killing_present[data$killing_low ==0 & data$YEAR>=1989 & data$YEAR<=2021] <- 0
data$killing_present[data$killing_low > 0 & data$YEAR>=1989 & data$YEAR<=2021] <- 1

## this dataset ends in 2015
data$mass_killing[is.na(data$mass_killing) & data$YEAR>=1945 &  data$YEAR<=2015] <- 0

## this doesn't really matter anymore because it refers back to an older version of pts 
data$genocide[data$COW==666.001] <- NA
data$rummel[data$COW==666.001] <- NA
data$killing_low[data$COW==666.001] <- NA
data$killing_best[data$COW==666.001] <- NA
data$killing_high[data$COW==666.001] <- NA
data$massive_repression[data$COW==666.001] <- NA

data$genocide[data$COW==666.002] <- NA
data$rummel[data$COW==666.002] <- NA
data$killing_low[data$COW==666.002] <- NA
data$killing_best[data$COW==666.002] <- NA
data$killing_high[data$COW==666.002] <- NA
data$massive_repression[data$COW==666.002] <- NA

data$genocide[data$COW==666.003] <- NA
data$rummel[data$COW==666.003] <- NA
data$killing_low[data$COW==666.003] <- NA
data$killing_best[data$COW==666.003] <- NA
data$killing_high[data$COW==666.003] <- NA
data$massive_repression[data$COW==666.003] <- NA

nrow(data)

#data <- na.omit(data)
# don't include !is.na(genocide) you predefined it to have full coverage but its okay now because it adds 3 values which have 2 or more items in the lag and lead year
data <- subset(data, !is.na(DISAP) | !is.na(KILL) | !is.na(TORT) | !is.na(POLPRIS) | 
                 !is.na(Amnesty) | !is.na(State) | !is.na(HRW) | !is.na(hathaway) | !is.na(ITT) | 
                 !is.na(genocide) | !is.na(rummel) | !is.na(massive_repression) | !is.na(executions) | 
                 !is.na(negative_sanctions) | !is.na(mass_killing) | !is.na(killing_low) | !is.na(killing_best) | 
                 !is.na(killing_high))
#| !is.na(pitf_low_killing) | !is.na(pitf_high_killing))
nrow(data)
n <- nrow(data)

data$COW_YEAR <- paste(data$COW, data$YEAR, sep="-")


id <- factor(data$COW_YEAR)
id <- as.numeric(id)
data$id <- id 

prev_id <- numeric(length(id))
for(ii in 1:length(id)){
  tmp.year <- data$YEAR[which(ii == id) ]
  tmp.COW <- data$COW[which(ii == id) ]
  
  if(any(((tmp.year-1) == data$YEAR) & (tmp.COW == data$COW))){
    prev_id[ii] <- id[((tmp.year-1) == data$YEAR) & (tmp.COW == data$COW)]
    
  } else {
    prev_id[ii] <- 0
  }
  
}

year <- data$YEAR - min(data$YEAR) + 1

# data$country <- as.numeric(as.factor(data$COW))
country <- as.numeric(as.factor(data$COW))

# year <- NA
# year[1] <- 1
# country <- NA
# panel <- NA
# panel.count <-1
# i <- 2
# country[1] <- 1
# j <- 1
# while(i <= nrow(data)){
#   if(data$COW[i]!=data$COW[i-1]){
#     panel[j] <- panel.count
#     panel.count <- 0
#     j <- j+1
#   }
#   country[i] <- j
#   #i <- i + 1
#   panel.count <- panel.count + 1
#   year[i] <- panel.count
#   i <- i + 1
# }
# j
# panel[j] <- panel.count

# # full model (14 items)
# y.pre <- as.matrix(data[,4:ncol(data)])
# y <- matrix(data=NA, ncol=ncol(y.pre), nrow=nrow(y.pre))
# for(i in 1:nrow(y.pre)){
#   for(j in 1:4){
#     y[i, j] <- as.numeric(y.pre[i, j]) + 1
#   }
#   for(j in 5:9){
#     y[i, j] <- as.numeric(y.pre[i, j])
#   }
#   for(j in 10:18){
#     y[i, j] <- as.numeric(y.pre[i, j])
#   }
# }
# 
# 
# head(y)

##### Split between standards and event based 
################### 


### Standards: CIRI DISAP, CIRI KILL, CIRI TORT, 
### PTS AMNESTY, PTS STATE, PTS HRW, HATHAWAY
standards <- c("DISAP","KILL", "TORT", "Amnesty", "State",
               "HRW", "hathaway")

## standards has to be separated because of the varying cutpoints
y_disap <- data$DISAP
latent_disap_id <-id[!is.na(y_disap)]
year_disap_id <- year[!is.na(y_disap)]
y_disap <- y_disap[!is.na(y_disap)]
N_disap <- length(y_disap)
table(y_disap)
y_disap <- y_disap + 1

y_kill <- data$KILL
latent_kill_id <-id[!is.na(y_kill)]
year_kill_id <- year[!is.na(y_kill)]
y_kill <- y_kill[!is.na(y_kill)]
N_kill <- length(y_kill)
table(y_kill)
y_kill <- y_kill + 1

y_tort <- data$TORT
latent_tort_id <-id[!is.na(y_tort)]
year_tort_id <- year[!is.na(y_tort)]
y_tort <- y_tort[!is.na(y_tort)]
N_tort <- length(y_tort)
table(y_tort)
y_tort <- y_tort + 1

y_amnesty <- data$Amnesty
latent_amnesty_id <-id[!is.na(y_amnesty)]
year_amnesty_id <- year[!is.na(y_amnesty)]
y_amnesty <- y_amnesty[!is.na(y_amnesty)]
N_amnesty <- length(y_amnesty)
table(y_amnesty)

y_state <- data$State
latent_state_id <-id[!is.na(y_state)]
year_state_id <- year[!is.na(y_state)]
y_state <- y_state[!is.na(y_state)]
N_state <- length(y_state)
table(y_state)

y_hrw <- data$HRW
latent_hrw_id <-id[!is.na(y_hrw)]
year_hrw_id <- year[!is.na(y_hrw)]
y_hrw <- y_hrw[!is.na(y_hrw)]
N_hrw <- length(y_hrw)
table(y_hrw)

y_hathaway <- data$hathaway
latent_hathaway_id <-id[!is.na(y_hathaway)]
year_hathaway_id <- year[!is.na(y_hathaway)]
y_hathaway <- y_hathaway[!is.na(y_hathaway)]
N_hathaway <- length(y_hathaway)
table(y_hathaway)



### Events: CIRI POLPRIS, ITT, Genocide, Rummel, 
### Massive Repression, WHIPSI Killing, 
### WHPSI Negative, Mass Killing, UCDP Killing

events <- c("POLPRIS", "ITT", "genocide", "rummel",
            "massive_repression", "executions", 
            "negative_sanctions", "mass_killing",
            "killing_low","killing_best", "killing_high")
# "pitf_low_killing", "pitf_high_killing")
y.events <- data[,colnames(data) %in% events]
n.bins.events <- apply(y.events, 2, function(x) max(x, na.rm=T) - min(x, na.rm=T) + 1)


y_events_2 <- y.events[,n.bins.events == 2]
J_events_2 <- sum(n.bins.events==2)
y_events_2 <- as.vector(y_events_2)
item_events_id_2 <- id.func(J_events_2, nrow(data))
item_events_id_2 <- item_events_id_2[!is.na(y_events_2)]
latent_events_id_2 <- rep(id, J_events_2)[!is.na(y_events_2)]
# year_events_id_2 <- rep(year, J_events_2)[!is.na(y_events_2)]
y_events_2 <- y_events_2[!is.na(y_events_2)]
N_events_2 <- length(y_events_2)
table(unlist(y_events_2), item_events_id_2)

y_events_3 <- y.events[,n.bins.events == 3]
J_events_3 <- sum(n.bins.events==3)
y_events_3 <- as.vector(y_events_3)
item_events_id_3 <- id.func(J_events_3, nrow(data))
item_events_id_3 <- item_events_id_3[!is.na(y_events_3)]
latent_events_id_3 <- rep(id, J_events_3)[!is.na(y_events_3)]
# year_events_id_3 <- rep(year, J_events_3)[!is.na(y_events_3)]
y_events_3 <- y_events_3[!is.na(y_events_3)]
N_events_3 <- length(y_events_3)
table(unlist(y_events_3), item_events_id_3)
y_events_3 <- y_events_3 + 1

y_events_6 <- y.events[,n.bins.events == 6]
J_events_6 <- sum(n.bins.events==6)
y_events_6 <- as.vector(y_events_6)
item_events_id_6 <- id.func(J_events_6, nrow(data))
item_events_id_6 <- item_events_id_6[!is.na(y_events_6)]
latent_events_id_6 <- rep(id, J_events_6)[!is.na(y_events_6)]
# year_events_id_6 <- rep(year, J_events_6)[!is.na(y_events_6)]
y_events_6 <- y_events_6[!is.na(y_events_6)]
N_events_6 <- length(y_events_6)
table(unlist(y_events_6), item_events_id_6)

y_events_C <- y.events[,n.bins.events > 10]
J_events_C <- sum(n.bins.events > 10)
y_events_C <- as.vector(y_events_C)
item_events_id_C <- id.func(J_events_C, nrow(data))
item_events_id_C <- item_events_id_C[!is.na(y_events_C)]
latent_events_id_C <- rep(id, J_events_C)[!is.na(y_events_C)]
year_events_id_C <- rep(year, J_events_C)[!is.na(y_events_C)]
country_events_id_C <- rep(country, J_events_C)[!is.na(y_events_C)]
y_events_C <- y_events_C[!is.na(y_events_C)]
N_events_C <- length(y_events_C)
plot(unlist(y_events_C)~item_events_id_C, log="y")

y_events_C_zinb <- y_events_C[item_events_id_C==1]
latent_events_id_C_zinb <- latent_events_id_C[item_events_id_C==1]
year_events_id_C_zinb <- year_events_id_C[item_events_id_C==1]
country_events_id_C_zinb <- country_events_id_C[item_events_id_C==1]
N_events_C_zinb <- length(y_events_C_zinb)

y_events_C_rest <- y_events_C[item_events_id_C!=1]
latent_events_id_C_rest <- latent_events_id_C[item_events_id_C!=1]
year_events_id_C_rest <- year_events_id_C[item_events_id_C!=1]
country_events_id_C_rest <- country_events_id_C[item_events_id_C!=1]
N_events_C_rest <- length(y_events_C_rest)
item_events_id_C_rest <- item_events_id_C[item_events_id_C!=1] - 1
J_events_C_rest <- max(item_events_id_C_rest)

y_killing_present <- data$killing_present
latent_killing_present_id <-id[!is.na(y_killing_present)]
year_killing_present_id <- year[!is.na(y_killing_present)]
y_killing_present <- y_killing_present[!is.na(y_killing_present)]
N_killing_present <- length(y_killing_present)
table(y_killing_present)


stan_data_list <- list(N=nrow(data), prev_id=prev_id,
                  N_disap=N_disap, y_disap=y_disap, latent_disap_id=latent_disap_id, year_disap_id=year_disap_id,
                  N_kill=N_kill, y_kill=y_kill, latent_kill_id=latent_kill_id, year_kill_id=year_kill_id,
                  N_tort=N_tort, y_tort=y_tort, latent_tort_id=latent_tort_id, year_tort_id=year_tort_id,
                  N_amnesty=N_amnesty, y_amnesty=y_amnesty, latent_amnesty_id=latent_amnesty_id, year_amnesty_id=year_amnesty_id,
                  N_state=N_state, y_state=y_state, latent_state_id=latent_state_id, year_state_id=year_state_id,
                  N_hrw=N_hrw, y_hrw=y_hrw, latent_hrw_id=latent_hrw_id, year_hrw_id=year_hrw_id,
                  N_hathaway=N_hathaway, y_hathaway=y_hathaway, latent_hathaway_id=latent_hathaway_id, year_hathaway_id=year_hathaway_id,
                  J_events_2=J_events_2, N_events_2=N_events_2, y_events_2=y_events_2, item_events_id_2=item_events_id_2,
                  latent_events_id_2=latent_events_id_2,
                  J_events_3=J_events_3, N_events_3=N_events_3, y_events_3=y_events_3, item_events_id_3=item_events_id_3,
                  latent_events_id_3=latent_events_id_3,
                  J_events_6=J_events_6, N_events_6=N_events_6, y_events_6=y_events_6, item_events_id_6=item_events_id_6,
                  latent_events_id_6=latent_events_id_6,
                  J_events_C=J_events_C, N_events_C=N_events_C, y_events_C=y_events_C, item_events_id_C=item_events_id_C,
                  latent_events_id_C=latent_events_id_C,
                  ### won't be used in all 
                  N_killing_present=N_killing_present, y_killing_present=y_killing_present, latent_killing_present_id=latent_killing_present_id,
                  year_N = max(year), country_N = max(country), 
                  country_events_id_C=country_events_id_C, year_events_id_C=year_events_id_C,
                  J_events_C_rest=J_events_C_rest, N_events_C_rest=N_events_C_rest, y_events_C_rest=y_events_C_rest, item_events_id_C_rest=item_events_id_C_rest,
                  latent_events_id_C_rest=latent_events_id_C_rest,
                  N_events_C_zinb=N_events_C_zinb, y_events_C_zinb=y_events_C_zinb,
                  latent_events_id_C_zinb=latent_events_id_C_zinb
)

# error
#data_processed$prev_id <- data_processed


##saveRDS
saveRDS(stan_data_list, file="LHRS-V4/data_processed/Stan_Data_Prepped_2021.RDS")
