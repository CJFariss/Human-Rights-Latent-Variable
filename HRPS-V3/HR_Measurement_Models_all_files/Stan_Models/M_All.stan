data {
	// DESCRIPTION
	// All intercepts Vary
	// NO count data (so the count binary killing_present is added instead)


	int N; // number of countries_years
	int prev_id[N];
	
	
	// Start with standards based
	int N_disap; // length of disap
	int y_disap[N_disap]; // vector of outcomes 
	int latent_disap_id[N_disap]; // vector that indexes latent variable 
	int year_disap_id[N_disap]; // vector that indexes year 
	
	int N_kill; // length of kill
	int y_kill[N_kill]; // vector of outcomes 
	int latent_kill_id[N_kill]; // vector that indexes latent variable 
	int year_kill_id[N_kill]; // vector that indexes year 
	
	int N_tort; // length of tort
	int y_tort[N_tort]; // vector of outcomes 
	int latent_tort_id[N_tort]; // vector that indexes latent variable 
	int year_tort_id[N_tort]; // vector that indexes year 
	
	int N_amnesty; // length of amnesty
	int y_amnesty[N_amnesty]; // vector of outcomes 
	int latent_amnesty_id[N_amnesty]; // vector that indexes latent variable
	int year_amnesty_id[N_amnesty]; // vector that indexes year 
	
	int N_state; // length of state
	int y_state[N_state]; // vector of outcomes 
	int latent_state_id[N_state]; // vector that indexes latent variable 
	int year_state_id[N_state]; // vector that indexes year 
	
	int N_hrw; // length of hrw
	int y_hrw[N_hrw]; // vector of outcomes 
	int latent_hrw_id[N_hrw]; // vector that indexes latent variable
	int year_hrw_id[N_hrw]; // vector that indexes year 
	
	int N_hathaway; // length of hathaway
	int y_hathaway[N_hathaway]; // vector of outcomes 
	int latent_hathaway_id[N_hathaway]; // vector that indexes latent variable
	int year_hathaway_id[N_hathaway]; // vector that indexes year 
		
	int N_POLPRIS; // length of POLPRIS
	int y_POLPRIS[N_POLPRIS]; // vector of outcomes 
	int latent_POLPRIS_id[N_POLPRIS]; // vector that indexes latent variable
	int year_POLPRIS_id[N_POLPRIS]; // vector that indexes year 
	
	int N_ITT; // length of ITT
	int y_ITT[N_ITT]; // vector of outcomes 
	int latent_ITT_id[N_ITT]; // vector that indexes latent variable
	int year_ITT_id[N_ITT]; // vector that indexes year 
	
	int N_genocide; // length of genocide
	int y_genocide[N_genocide]; // vector of outcomes 
	int latent_genocide_id[N_genocide]; // vector that indexes latent variable
	int year_genocide_id[N_genocide]; // vector that indexes year 
	
	int N_rummel; // length of rummel
	int y_rummel[N_rummel]; // vector of outcomes 
	int latent_rummel_id[N_rummel]; // vector that indexes latent variable
	int year_rummel_id[N_rummel]; // vector that indexes year 
	
	int N_massive_repression; // length of massive_repression
	int y_massive_repression[N_massive_repression]; // vector of outcomes 
	int latent_massive_repression_id[N_massive_repression]; // vector that indexes latent variable
	int year_massive_repression_id[N_massive_repression]; // vector that indexes year 
	
	int N_executions; // length of executions
	int y_executions[N_executions]; // vector of outcomes 
	int latent_executions_id[N_executions]; // vector that indexes latent variable
	int year_executions_id[N_executions]; // vector that indexes year 
	
	int N_negative_sanctions; // length of negative_sanctions
	int y_negative_sanctions[N_negative_sanctions]; // vector of outcomes 
	int latent_negative_sanctions_id[N_negative_sanctions]; // vector that indexes latent variable
	int year_negative_sanctions_id[N_negative_sanctions]; // vector that indexes year 

	int N_mass_killing; // length of mass_killing
	int y_mass_killing[N_mass_killing]; // vector of outcomes 
	int latent_mass_killing_id[N_mass_killing]; // vector that indexes latent variable
	int year_mass_killing_id[N_mass_killing]; // vector that indexes year 
	
	int N_killing_present; // length of hathaway
	int y_killing_present[N_killing_present]; // vector of outcomes 
	int latent_killing_present_id[N_killing_present]; // vector that indexes latent variable
	int year_killing_present_id[N_killing_present]; // vector that indexes year 



}

transformed data {

	// Now to figure out how many years each of the standards based indicator has
	
	int min_year_disap = min(year_disap_id);
	int max_year_disap = max(year_disap_id);

	int min_year_kill = min(year_kill_id);
	int max_year_kill = max(year_kill_id);

	int min_year_tort = min(year_tort_id);
	int max_year_tort = max(year_tort_id);	
	
	int min_year_amnesty = min(year_amnesty_id);
	int max_year_amnesty = max(year_amnesty_id);

	int min_year_state = min(year_state_id);
	int max_year_state = max(year_state_id);

	int min_year_hrw = min(year_hrw_id);
	int max_year_hrw = max(year_hrw_id);	
	
	int min_year_hathaway = min(year_hathaway_id);
	int max_year_hathaway = max(year_hathaway_id);
	
	int min_year_POLPRIS = min(year_POLPRIS_id);
	int max_year_POLPRIS = max(year_POLPRIS_id);
	
	int min_year_ITT = min(year_ITT_id);
	int max_year_ITT = max(year_ITT_id);
	
	int min_year_genocide = min(year_genocide_id);
	int max_year_genocide = max(year_genocide_id);
	
	int min_year_rummel = min(year_rummel_id);
	int max_year_rummel = max(year_rummel_id);
	
	int min_year_massive_repression = min(year_massive_repression_id);
	int max_year_massive_repression = max(year_massive_repression_id);
	
	int min_year_executions = min(year_executions_id);
	int max_year_executions = max(year_executions_id);
	
	int min_year_negative_sanctions = min(year_negative_sanctions_id);
	int max_year_negative_sanctions = max(year_negative_sanctions_id);

	int min_year_mass_killing = min(year_mass_killing_id);
	int max_year_mass_killing = max(year_mass_killing_id);
	
	int min_year_killing_present = min(year_killing_present_id);
	int max_year_killing_present = max(year_killing_present_id);

	
}

parameters {

	// latent variable parameters
	vector[N] theta_raw; // matrix of raw thetas
	real<lower=0, upper=1> sigma; // innovation parameter

	//standards based with 2 indicators 
	real<lower=0> beta_disap; 
	ordered[2] cut_disap[max_year_disap - min_year_disap + 1];

	real<lower=0> beta_kill; 
	ordered[2] cut_kill[max_year_kill - min_year_kill + 1];
	
	real<lower=0> beta_tort; 
	ordered[2] cut_tort[max_year_tort - min_year_tort + 1];	
	
	real<lower=0> beta_amnesty; 
	ordered[4] cut_amnesty[max_year_amnesty - min_year_amnesty + 1];
	
	real<lower=0> beta_state; 
	ordered[4] cut_state[max_year_state - min_year_state + 1];
	
	real<lower=0> beta_hrw; 
	ordered[4] cut_hrw[max_year_hrw - min_year_hrw + 1];	
	
	real<lower=0> beta_hathaway; 
	ordered[4] cut_hathaway[max_year_hathaway - min_year_hathaway + 1];	

	real<lower=0> beta_POLPRIS; 
	ordered[2] cut_POLPRIS[max_year_POLPRIS - min_year_POLPRIS + 1];	

	real<lower=0> beta_ITT; 
	ordered[5] cut_ITT[max_year_ITT - min_year_ITT + 1];	

	real<lower=0> beta_genocide; 
	vector[max_year_genocide - min_year_genocide + 1] alpha_genocide;	

	real<lower=0> beta_rummel; 
	vector[max_year_rummel - min_year_rummel + 1] alpha_rummel;	

	real<lower=0> beta_massive_repression; 
	vector[max_year_massive_repression - min_year_massive_repression + 1] alpha_massive_repression;	

	real<lower=0> beta_executions; 
	vector[max_year_executions - min_year_executions + 1] alpha_executions;	

	real<lower=0> beta_negative_sanctions; 
	vector[max_year_negative_sanctions - min_year_negative_sanctions + 1] alpha_negative_sanctions;	

	real<lower=0> beta_mass_killing; 
	vector[max_year_mass_killing - min_year_mass_killing + 1] alpha_mass_killing;	

	real<lower=0> beta_killing_present; 
	vector[max_year_killing_present - min_year_killing_present + 1] alpha_killing_present;	

	
}

transformed parameters {
	vector[N] theta; // actual theta

	// first year doesn't need to be adjusted
	for(ii in 1:N){
		if(prev_id[ii]==0){
			theta[ii] = theta_raw[ii];
		} else {
			{
			real tmp;
			tmp = theta[prev_id[ii]];
			theta[ii] =  tmp + theta_raw[ii] * sigma; 
			}
		}
	}

}

model {

	theta_raw ~ normal(0, 1);
	sigma ~ uniform(0, 1); // unnecessary 
	

	// standards below
	
	/// DISAP IS POSITIVE
	beta_disap ~ gamma(4,3);
	cut_disap[1,] ~ normal(0,4);
	for(ii in 2:(max_year_disap - min_year_disap+1)){
		cut_disap[ii,] ~ normal(cut_disap[ii-1,], 4);
	}
		
	for(ii in 1:N_disap){
		y_disap[ii] ~ ordered_logistic((beta_disap) * theta[latent_disap_id[ii]], 
						to_vector(cut_disap[year_disap_id[ii] - min_year_disap + 1,] )) ;
	}
	
	
	/// KILL IS POSITIVE
	beta_kill ~ gamma(4,3);
	cut_kill[1,] ~ normal(0,4);
	for(ii in 2:(max_year_kill - min_year_kill+1)){
		cut_kill[ii,] ~ normal(cut_kill[ii-1,], 4);
	}
		
	for(ii in 1:N_kill){
		y_kill[ii] ~ ordered_logistic((beta_kill) * theta[latent_kill_id[ii]], 
						to_vector(cut_kill[year_kill_id[ii] - min_year_kill + 1,] )) ;
	}
	
	
	/// TORT IS POSITIVE 
	beta_tort ~ gamma(4,3);
	cut_tort[1,] ~ normal(0,4);
	for(ii in 2:(max_year_tort - min_year_tort+1)){
		cut_tort[ii,] ~ normal(cut_tort[ii-1,], 4);
	}
		
	for(ii in 1:N_tort){
		y_tort[ii] ~ ordered_logistic((beta_tort) * theta[latent_tort_id[ii]], 
						to_vector(cut_tort[year_tort_id[ii] - min_year_tort + 1,] )) ;
	}

	
	/// AMNESTY IS NEGATIVE
	beta_amnesty ~ gamma(4,3);
	cut_amnesty[1,] ~ normal(0,4);
	for(ii in 2:(max_year_amnesty - min_year_amnesty+1)){
		cut_amnesty[ii,] ~ normal(cut_amnesty[ii-1,], 4);
	}
		
	for(ii in 1:N_amnesty){
		y_amnesty[ii] ~ ordered_logistic((-beta_amnesty) * theta[latent_amnesty_id[ii]], 
						to_vector(cut_amnesty[year_amnesty_id[ii]  - min_year_amnesty + 1,] )) ;
	}
	
	
	/// STATE IS NEGATIVE
	beta_state ~ gamma(4,3);
	cut_state[1,] ~ normal(0,4);
	for(ii in 2:(max_year_state - min_year_state+1)){
		cut_state[ii,] ~ normal(cut_state[ii-1,], 4);
	}
		
	for(ii in 1:N_state){
		y_state[ii] ~ ordered_logistic((-beta_state) * theta[latent_state_id[ii]], 
						to_vector(cut_state[year_state_id[ii]  - min_year_state + 1,] )) ;
	}
	
	
	/// HRW IS NEGATIVE 
	beta_hrw ~ gamma(4,3);
	cut_hrw[1,] ~ normal(0,4);
	for(ii in 2:(max_year_hrw - min_year_hrw+1)){
		cut_hrw[ii,] ~ normal(cut_hrw[ii-1,], 4);
	}
		
	for(ii in 1:N_hrw){
		y_hrw[ii] ~ ordered_logistic((-beta_hrw) * theta[latent_hrw_id[ii]], 
					to_vector(cut_hrw[year_hrw_id[ii]  - min_year_hrw + 1,] )) ;
	}

	
	/// HATHAWAY IS NEGATIVE
	beta_hathaway ~ gamma(4,3);
	cut_hathaway[1,] ~ normal(0,4);
	for(ii in 2:(max_year_hathaway - min_year_hathaway+1)){
		cut_hathaway[ii,] ~ normal(cut_hathaway[ii-1,], 4);
	}
		
	for(ii in 1:N_hathaway){
		y_hathaway[ii] ~ ordered_logistic((-beta_hathaway) * theta[latent_hathaway_id[ii]], 
						to_vector(cut_hathaway[year_hathaway_id[ii]  - min_year_hathaway + 1,] )) ;
	}

	
	/// POLPRIS IS POSITIVE 	
	beta_POLPRIS ~ gamma(4,3);
	cut_POLPRIS[1,] ~ normal(0,4);
	for(ii in 2:(max_year_POLPRIS - min_year_POLPRIS+1)){
		cut_POLPRIS[ii,] ~ normal(cut_POLPRIS[ii-1,], 4);
	}
		
	for(ii in 1:N_POLPRIS){
		y_POLPRIS[ii] ~ ordered_logistic((beta_POLPRIS) * theta[latent_POLPRIS_id[ii]], 
						to_vector(cut_POLPRIS[year_POLPRIS_id[ii]  - min_year_POLPRIS + 1,] )) ;
	}
	
	
	// ITT IS NEGATIVE 
	beta_ITT ~ gamma(4,3);
	cut_ITT[1,] ~ normal(0,4);
	for(ii in 2:(max_year_ITT - min_year_ITT+1)){
		cut_ITT[ii,] ~ normal(cut_ITT[ii-1,], 4);
	}
		
	for(ii in 1:N_ITT){
		y_ITT[ii] ~ ordered_logistic((-beta_ITT) * theta[latent_ITT_id[ii]], 
						to_vector(cut_ITT[year_ITT_id[ii]  - min_year_ITT + 1,] )) ;
	}
	

	/// GENOCIDE IS NEGATIVE 
	beta_genocide ~ gamma(4,3);
	alpha_genocide[1] ~ normal(0,4);
	for(ii in 2:(max_year_genocide - min_year_genocide+1)){
		alpha_genocide[ii] ~ normal(alpha_genocide[ii-1], 4);
	}
	
	for(ii in 1:N_genocide){
		y_genocide[ii] ~ bernoulli_logit(alpha_genocide[year_genocide_id[ii] - min_year_genocide + 1] 
		- beta_genocide* theta[latent_genocide_id[ii]] );
	}
	
	
	/// RUMMEL IS NEGATIVE 
	beta_rummel ~ gamma(4,3);
	alpha_rummel[1] ~ normal(0,4);
	for(ii in 2:(max_year_rummel - min_year_rummel+1)){
		alpha_rummel[ii] ~ normal(alpha_rummel[ii-1], 4);
	}
	
	for(ii in 1:N_rummel){
		y_rummel[ii] ~ bernoulli_logit(alpha_rummel[year_rummel_id[ii] - min_year_rummel + 1] 
			- beta_rummel* theta[latent_rummel_id[ii]] );
	}
	

	/// MASSIVE_REPRESSION IS NEGATIVE 
	beta_massive_repression ~ gamma(4,3);
	alpha_massive_repression[1] ~ normal(0,4);
	for(ii in 2:(max_year_massive_repression - min_year_massive_repression+1)){
		alpha_massive_repression[ii] ~ normal(alpha_massive_repression[ii-1], 4);
	}
	
	for(ii in 1:N_massive_repression){
	y_massive_repression[ii] ~ bernoulli_logit(alpha_massive_repression[year_massive_repression_id[ii] - min_year_massive_repression + 1] 
		- beta_massive_repression* theta[latent_massive_repression_id[ii]] ); 
	}


	/// EXECUTIONS IS NEGATIVE 
	beta_executions ~ gamma(4,3);
	alpha_executions[1] ~ normal(0,4);
	for(ii in 2:(max_year_executions - min_year_executions+1)){
		alpha_executions[ii] ~ normal(alpha_executions[ii-1], 4);
	}
	
	for(ii in 1:N_executions){
		y_executions[ii] ~ bernoulli_logit(alpha_executions[year_executions_id[ii] - min_year_executions + 1] 
			- beta_executions* theta[latent_executions_id[ii]] );
	}
	
	
	/// NEGATIVE_SANCTIONS IS NEGATIVE 
	beta_negative_sanctions ~ gamma(4,3);
	alpha_negative_sanctions[1] ~ normal(0,4);
	for(ii in 2:(max_year_negative_sanctions - min_year_negative_sanctions+1)){
		alpha_negative_sanctions[ii] ~ normal(alpha_negative_sanctions[ii-1], 4);
	}
	
	for(ii in 1:N_negative_sanctions){
		y_negative_sanctions[ii] ~ bernoulli_logit(alpha_negative_sanctions[year_negative_sanctions_id[ii] - min_year_negative_sanctions + 1] 
			- beta_negative_sanctions* theta[latent_negative_sanctions_id[ii]] );	
	}


	/// MASS_KILLING IS NEGATIVE 
	beta_mass_killing ~ gamma(4,3);
	alpha_mass_killing[1] ~ normal(0,4);
	for(ii in 2:(max_year_mass_killing - min_year_mass_killing+1)){
		alpha_mass_killing[ii] ~ normal(alpha_mass_killing[ii-1], 4);
	}
	
	for(ii in 1:N_mass_killing){
		y_mass_killing[ii] ~ bernoulli_logit(alpha_mass_killing[year_mass_killing_id[ii] - min_year_mass_killing + 1] 
			- beta_mass_killing* theta[latent_mass_killing_id[ii]] );
	}
	

	/// KILLING_PRESENT IS NEGATIVE 
	beta_killing_present ~ gamma(4,3);
	alpha_killing_present[1] ~ normal(0,4);
	for(ii in 2:(max_year_killing_present - min_year_killing_present+1)){
		alpha_killing_present[ii] ~ normal(alpha_killing_present[ii-1], 4);
	}
	
	for(ii in 1:N_killing_present){
		y_killing_present[ii] ~ bernoulli_logit(alpha_killing_present[year_killing_present_id[ii] - min_year_killing_present + 1] 
		- beta_killing_present* theta[latent_killing_present_id[ii]] );
	}

	
}

generated quantities {
	vector[N_disap] pred_disap;
	vector[N_kill] pred_kill;
	vector[N_tort] pred_tort;
	vector[N_amnesty] pred_amnesty;
	vector[N_state] pred_state;
	vector[N_hrw] pred_hrw;
	vector[N_hathaway] pred_hathaway;
	vector[N_POLPRIS] pred_POLPRIS;
	vector[N_ITT] pred_ITT;
	vector[N_genocide] pred_genocide;
	vector[N_rummel] pred_rummel;
	vector[N_massive_repression] pred_massive_repression;
	vector[N_executions] pred_executions;
	vector[N_negative_sanctions] pred_negative_sanctions;
	vector[N_mass_killing] pred_mass_killing;
	vector[N_killing_present] pred_killing_present;
	
	for(ii in 1:N_disap){
		pred_disap[ii] = ordered_logistic_rng((beta_disap) * theta[latent_disap_id[ii]], 
						to_vector(cut_disap[year_disap_id[ii] - min_year_disap + 1,] )) ;
	}
	
	
	for(ii in 1:N_kill){
		pred_kill[ii] = ordered_logistic_rng((beta_kill) * theta[latent_kill_id[ii]], 
						to_vector(cut_kill[year_kill_id[ii] - min_year_kill + 1,] )) ;
	}
	
	
	for(ii in 1:N_tort){
		pred_tort[ii] = ordered_logistic_rng((beta_tort) * theta[latent_tort_id[ii]], 
						to_vector(cut_tort[year_tort_id[ii] - min_year_tort + 1,] )) ;
	}

		
	for(ii in 1:N_amnesty){
		pred_amnesty[ii] = ordered_logistic_rng((-beta_amnesty) * theta[latent_amnesty_id[ii]], 
						to_vector(cut_amnesty[year_amnesty_id[ii]  - min_year_amnesty + 1,] )) ;
	}
	

	for(ii in 1:N_state){
		pred_state[ii] = ordered_logistic_rng((-beta_state) * theta[latent_state_id[ii]], 
						to_vector(cut_state[year_state_id[ii]  - min_year_state + 1,] )) ;
	}
	

	for(ii in 1:N_hrw){
		pred_hrw[ii] = ordered_logistic_rng((-beta_hrw) * theta[latent_hrw_id[ii]], 
					to_vector(cut_hrw[year_hrw_id[ii]  - min_year_hrw + 1,] )) ;
	}


	for(ii in 1:N_hathaway){
		pred_hathaway[ii] = ordered_logistic_rng((-beta_hathaway) * theta[latent_hathaway_id[ii]], 
						to_vector(cut_hathaway[year_hathaway_id[ii]  - min_year_hathaway + 1,] )) ;
	}


	for(ii in 1:N_POLPRIS){
		pred_POLPRIS[ii] = ordered_logistic_rng((beta_POLPRIS) * theta[latent_POLPRIS_id[ii]], 
						to_vector(cut_POLPRIS[year_POLPRIS_id[ii]  - min_year_POLPRIS + 1,] )) ;
	}
	

	for(ii in 1:N_ITT){
		pred_ITT[ii] = ordered_logistic_rng((-beta_ITT) * theta[latent_ITT_id[ii]], 
						to_vector(cut_ITT[year_ITT_id[ii]  - min_year_ITT + 1,] )) ;
	}
	

	for(ii in 1:N_genocide){
		pred_genocide[ii] = bernoulli_logit_rng(alpha_genocide[year_genocide_id[ii] - min_year_genocide + 1] 
		- beta_genocide* theta[latent_genocide_id[ii]] );
	}
	

	for(ii in 1:N_rummel){
		pred_rummel[ii] = bernoulli_logit_rng(alpha_rummel[year_rummel_id[ii] - min_year_rummel + 1] 
			- beta_rummel* theta[latent_rummel_id[ii]] );
	}
	

	for(ii in 1:N_massive_repression){
	pred_massive_repression[ii] = bernoulli_logit_rng(alpha_massive_repression[year_massive_repression_id[ii] - min_year_massive_repression + 1] 
		- beta_massive_repression* theta[latent_massive_repression_id[ii]] ); 
	}


	for(ii in 1:N_executions){
		pred_executions[ii] = bernoulli_logit_rng(alpha_executions[year_executions_id[ii] - min_year_executions + 1] 
			- beta_executions* theta[latent_executions_id[ii]] );
	}
	

	for(ii in 1:N_negative_sanctions){
		pred_negative_sanctions[ii] = bernoulli_logit_rng(alpha_negative_sanctions[year_negative_sanctions_id[ii] - min_year_negative_sanctions + 1] 
			- beta_negative_sanctions* theta[latent_negative_sanctions_id[ii]] );	
	}


	for(ii in 1:N_mass_killing){
		pred_mass_killing[ii] = bernoulli_logit_rng(alpha_mass_killing[year_mass_killing_id[ii] - min_year_mass_killing + 1] 
			- beta_mass_killing* theta[latent_mass_killing_id[ii]] );
	}
	

	for(ii in 1:N_killing_present){
		pred_killing_present[ii] = bernoulli_logit_rng(alpha_killing_present[year_killing_present_id[ii] - min_year_killing_present + 1] 
		- beta_killing_present* theta[latent_killing_present_id[ii]] );
	}
	
	
}


