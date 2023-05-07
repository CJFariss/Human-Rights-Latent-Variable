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
# setwd("D:/Dropbox/Projects/HR_Validation")
setwd("~/HR_Validation")
.libPaths("~/.Rlibs")

#### rstan version 2.15.1
#### R version 3.3.1
library(rstan)
library(MASS)
library(rms)
# library(loo)
load("Stan_Data_Prepped.RData")

values <- read.csv("control_values_2.csv", stringsAsFactors = F)


model <- paste("Stan_Models/", values$mod[select], ".stan", sep="")


model <- readLines(model)
# 
# tmp.df <- read.csv(paste("Stan_Models/", values$drop_file[select], ".csv", sep=""))
# rownames(tmp.df) <- tmp.df$Var
# tmp.df$Var <- NULL
# 
# drop <- as.numeric(tmp.df[values$variable[select], ])
# drop <- drop[!is.na(drop)]
# model <- model[-drop]


# mod <- stan(model_code=model, data=stan.data, iter=2000, 
#             chains=4,
#             cores = 1, verbose=F, pars="theta_raw", include = F, thin=2,
#             seed = 61717, control=list(max_treedepth=15))

mod <- stan(model_code=model, data=stan.data, iter=2000, 
            chains=4,
            cores = 4, verbose=F, pars=c("theta"),
            include = T, thin=2,
            seed = 61717, control=list(max_treedepth=15))



save.image(paste("Stan_Models/", values$mod[select], ".RData", sep=""))

q()


write.csv(summary(mod)$summary, file=paste("out/summary_", values$fill_append[select], ".csv", sep=""))



thetas <- extract(mod, pars="theta")
thetas <- thetas$theta

ids <- get(values$id[select])
y <- get(values$y[select])
k <- 10
set.seed(1)
if(length(unique(y))==2){
  accuracy <- numeric(nrow(thetas))
  for(jj in 1:nrow(thetas)){
    accuracy.tmp <- numeric(k)
    n.sample <- sample(1:k, length(y), replace = T)
    for(ii in 1:k){
      x <- thetas[jj,ids[n.sample!=ii]]
      mod <- glm(as.factor(y[n.sample!=ii])~x, family=binomial(link="logit"))
      
      n.x <- data.frame("x"=thetas[jj,ids[n.sample==ii]])
      pred <- predict(mod, newdata = n.x, type="response")
      confusion <- table((pred>.5)*1, y[n.sample==ii])
      accuracy.tmp[ii] <- sum(diag(confusion))/sum(confusion)
    }
    accuracy[jj] <- mean(accuracy.tmp)
  }

} else {
  accuracy <- numeric(nrow(thetas))
  for(jj in 1:nrow(thetas)){
    accuracy.tmp <- numeric(k)
    n.sample <- sample(1:k, length(y), replace = T)
    for(ii in 1:k){
      x <- thetas[jj,ids[n.sample!=ii]]
      mod <- polr(as.factor(y[n.sample!=ii])~x)
      
      n.x <- data.frame("x"=thetas[jj,ids[n.sample==ii]])
      confusion <- table(predict(mod, newdata = n.x), y[n.sample==ii])
      accuracy.tmp[ii] <- sum(diag(confusion))/sum(confusion)
    }
    accuracy[jj] <- mean(accuracy.tmp)
  }
}

write.csv(data.frame("accuracy"=accuracy), paste("out/accuracy_" , values$fill_append[select], ".csv", sep="" ) )

countries <- unique(country[ids])
n.country <- length(countries)
cors <- matrix(NA, nrow=nrow(thetas), ncol=n.country)

for(ii in 1:n.country){
  cors[,ii] <- apply(thetas[,ids[country==countries[ii]]], 1, 
                     function(x) cor(x, y[country==countries[ii]], method="spearman"))
}


write.csv(data.frame("cors"=cors), paste("out/correlations_country" , values$fill_append[select], ".csv", sep=""))

x <- colMeans(thetas[,ids])
year.tmp <- year[ids]
dd <- datadist(x, year.tmp)
options(datadist="dd")
if(length(unique(y))>3){
  mod <- orm(as.factor(y)~rcs(year.tmp)*x)
  
  levels <- sort(unique(y))
  levels <- levels[-length(levels)]
  for(jj in 1:length(levels)){
    pdf(paste("plots/inter_",values$fill_append[select], "_", levels[jj], ".pdf", sep=""))
    ggplot(Predict(mod, year.tmp=seq(1, max(year.tmp), by=1), x, np=3, kint=levels[jj]))
    dev.off()
  }
} else {
  mod <- lrm(as.factor(y)~rcs(year.tmp)*x)
  
  pdf(paste("plots/inter_",values$fill_append[select], ".pdf", sep=""))
  ggplot(Predict(mod, year.tmp=seq(1, max(year.tmp), by=1), x, np=3))
  dev.off()
  
}


pdf(paste("plots/dir_",values$fill_append[select], ".pdf", sep=""))
ggplot(Predict(mod, x))
ggplot(Predict(mod, year.tmp))
dev.off()


save.image("images/", values$fill_append[select], ".RData", sep="")
quit(save="no")
