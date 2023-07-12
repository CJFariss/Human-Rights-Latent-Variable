#args <- commandArgs(trailingOnly = T)
#if(length(args)!=1){
#  stop("Must give args: RScript.exe HPC.R --args 'id'")
#} else {
#  selection <- as.numeric(args[1])
#}
# 
# setwd("D:/Dropbox/Projects/HR_latent_event_count/StaN_Version/Umich_Phase_1")
# setwd("C:/users/kjr228/Dropbox/Projects/HR_latent_event_count/Umich_Phase_1")
# setwd("/home/kreuning/phase_3")
# setwd("/Users/cjfariss/Dropbox/HR_latent_event_count/Stan_Version/UMich_Phase_4_2017")
# .libPaths("~/.Rlibs")
#setwd("C:/Users/reunink/Dropbox/Projects/HR_latent_event_count/Stan_Version/UMich_Phase_4_2017")
selection <- 4
#### rstan version 2.15.1
#### R version 3.3.1
library(rstan)
library(loo)
#load("Stan_Data_Prepped_2017.RData")
#load("Stan_Data_Prepped_2018.RData")
#load("Stan_Data_Prepped_2019.RData")
#load("Stan_Data_Prepped_2020.RData")
#stan.data <- readRDS("./data_processed/Stan_Data_Prepped_2021.RDS")
#stan.data <- readRDS("LHRS-V5/data_processed/Stan_Data_Prepped_2021.RDS")
stan.data <- readRDS("LHRS-V5/data_processed/Stan_Data_Prepped_2022.RDS")

#deg_free <- rep(4, length(prev_id))
#deg_free[prev_id==0] <- 1000

stan.data$deg_free <- rep(4, length(stan.data$prev_id))
stan.data$deg_free[stan.data$prev_id==0] <- 1000

#stan.data$deg_free = deg_free

#values <- read.csv("./control_values.csv")
values <- read.csv("LHRS-V5/control_values.csv")
values

#models <- c("M_4_ZIP", "M_Fixed_ZINB", "M_Fixed_ZIP", "M_Fixed_ZIQP")
#models <- c("M_Fixed")
#models <- c("M_Standards")
#models <- c("M_2_Robust")
models <- c("M_Fixed_ZINB")

selection <- 1

print(selection)
model <- models[selection]
print(model)

#temp <- stan_model(file=paste("./", model, ".stan", sep="")) 
temp <- stan_model(file=paste("LHRS-V5/", model, ".stan", sep="")) 
mod <- sampling(temp, 
                data=stan.data, 
                iter=values$iter[1], 
                chains=4, #values$chains[1], 
                cores=4, #values$cores[1], 
                verbose=F, 
                pars=c("theta_raw", "r_year_raw","r_country_raw"),
                include = F, 
                thin=values$thin[1],
                seed = 61717, 
                control=list(max_treedepth=15)
                )


test <- summary(mod)$summary
write.csv(test, file=paste("LHRS-V5/data_estimates/", model, "_summary.csv", sep=""))

out <- extract(mod)

theta_mean <- apply(out$theta, 2, mean)
theta_sd <- apply(out$theta, 2, sd)


data$theta_mean <- NA
data$theta_sd <- NA
for(ii in 1:nrow(data)){
  data$theta_mean[ii] <- theta_mean[id[ii]]
  data$theta_sd[ii] <- theta_sd[id[ii]]
  
}


#write.csv(data, paste(model, "Full_Data_2019.csv", sep="_"))
#write.csv(data, paste(model, "Full_Data_2020.csv", sep="_"))
write.csv(data, file=paste("LHRS-V5/data_estimates/", model, "_Full_Data_2021.csv", sep=""))

var.names <- names(out)
rm(out)


ll <- extract_log_lik(mod, grep("ll_", var.names, value=T))

#write.csv(ll, file=paste(model, "LL_2020.csv", sep="_"))
write.csv(ll, file=paste("LHRS-V5/data_estimates/", model, "_LL_2021.csv", sep=""))


post.var <- as.matrix(mod, par=var.names[!grepl("ll_", var.names)])


#write.csv(post.var, file=paste(model, "Par_2020.csv", sep="_"), row.names=F)
write.csv(post.var, file=paste("LHRS-V5/data_estimates/", model, "_Par_2021.csv", sep=""))

#save.image("Stan_Run_Models_2020.RData")
#save.image("./data_processed/Stan_Run_Models_2019.RData")
save.image("./data_processed/Stan_Run_Models_2021.RData")

rm(list=ls())


