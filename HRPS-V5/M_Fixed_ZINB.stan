data {
	// DESCRIPTION
	// Dynamic intercept for standards
	// Static intercept for events 
	// Count data  have the same alpha & beta across all three types, 
	// but the rate variable is estimated for each of the three types
	// I think this is Model 6 in the paper

	int N; // number of countries_years
	int prev_id[N];
	real deg_free[N];
	
	// Start with standards based
	int N_disap; // length of disap
	int y_disap[N_disap]; // vector of outcomes 
	int latent_disap_id[N_disap]; // vector that indexes country 
	int year_disap_id[N_disap]; // vector that indexes year 
	
	int N_kill; // length of kill
	int y_kill[N_kill]; // vector of outcomes 
	int latent_kill_id[N_kill]; // vector that indexes country 
	int year_kill_id[N_kill]; // vector that indexes year 
	
	int N_tort; // length of tort
	int y_tort[N_tort]; // vector of outcomes 
	int latent_tort_id[N_tort]; // vector that indexes country 
	int year_tort_id[N_tort]; // vector that indexes year 
	
	int N_amnesty; // length of amnesty
	int y_amnesty[N_amnesty]; // vector of outcomes 
	int latent_amnesty_id[N_amnesty]; // vector that indexes country 
	int year_amnesty_id[N_amnesty]; // vector that indexes year 
	
	int N_state; // length of state
	int y_state[N_state]; // vector of outcomes 
	int latent_state_id[N_state]; // vector that indexes country 
	int year_state_id[N_state]; // vector that indexes year 
	
	int N_hrw; // length of hrw
	int y_hrw[N_hrw]; // vector of outcomes 
	int latent_hrw_id[N_hrw]; // vector that indexes country 
	int year_hrw_id[N_hrw]; // vector that indexes year 
	
	int N_hathaway; // length of hathaway
	int y_hathaway[N_hathaway]; // vector of outcomes 
	int latent_hathaway_id[N_hathaway]; // vector that indexes country 
	int year_hathaway_id[N_hathaway]; // vector that indexes year 
	
	
	// Now go to event based (same but needs to be separated)
	int J_events_2; // number of events based items with 2 cat
	int N_events_2; // length of 2 cat events based vector 
	int y_events_2[N_events_2]; // vector of outcomes 
	int item_events_id_2[N_events_2]; // vector that indexes items 
	int latent_events_id_2[N_events_2]; // vector that indexes country 
	//int year_events_id_2[N_events_2]; // vector that indexes year 
	
	int J_events_3; // number of events based items with 3 cat
	int N_events_3; // length of 3 cat events based vector 
	int y_events_3[N_events_3]; // vector of outcomes 
	int item_events_id_3[N_events_3]; // vector that indexes items 
	int latent_events_id_3[N_events_3]; // vector that indexes country 
	//int year_events_id_3[N_events_3]; // vector that indexes year 
	
	int J_events_6; // number of events based items with 6 cat
	int N_events_6; // length of 6 cat events based vector 
	int y_events_6[N_events_6]; // vector of outcomes 
	int item_events_id_6[N_events_6]; // vector that indexes items 
	int latent_events_id_6[N_events_6]; // vector that indexes country 
	//int year_events_id_6[N_events_6]; // vector that indexes year 
	
	/// And finally count data, keeping the J for future use
	int J_events_C; // number of count indicators
	int N_events_C; // length of count  vector 
	int y_events_C[N_events_C]; // vector of outcomes 
	int item_events_id_C[N_events_C]; // vector that indexes items 
	int latent_events_id_C[N_events_C]; // vector that indexes country 
	//int year_events_id_C[N_events_C]; // vector that indexes year 

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

	
	// events with 2 cats
	vector<lower=0>[J_events_2] beta_events_2;
	vector[J_events_2] alpha_events_2;
	
	// events with 3 cats
	real<lower=0> beta_events_3[J_events_3];
	ordered[2] cut_events_3[J_events_3];
	
	//events with 6 cats
	real<lower=0> beta_events_6[J_events_6];
	ordered[5] cut_events_6[J_events_6];
	// ordered[5] cut_events_6;
	
 	//counts
	real alpha_events_C_pos;
	real<lower=0> beta_events_C_pos; 
	
	real alpha_events_C_zinb;
	real<lower=0> beta_events_C_zinb; 
	real<lower=0> r; // dispersion parameter

	
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

	theta_raw ~ student_t(deg_free, 0, 1);
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
	
	
	/////////////////////////
	// event info is below
	/////////////////////////
	
	
	beta_events_2 ~ gamma(4, 3);
	alpha_events_2 ~ normal(0, 4);
	
	/// ALL 2 CAT EVENTS ARE NEGATIVE 
	y_events_2 ~ bernoulli_logit(alpha_events_2[item_events_id_2] - beta_events_2[item_events_id_2] .* theta[latent_events_id_2] );
	
	
	
	/// ALL 3 CAT EVENTS ARE POSITIVE 	
	beta_events_3 ~ gamma(4, 3);
	for(ii in 1:J_events_3){
		cut_events_3[ii,] ~ normal(0, 4);
	}
	
	for(ii in 1:N_events_3){
		y_events_3[ii] ~ ordered_logistic((beta_events_3[item_events_id_3[ii]]) * theta[latent_events_id_3[ii]], 
											cut_events_3[item_events_id_3[ii],]) ;
	}	 
	 
	 
	// ALL 6 EVENTS CATS ARE NEGATIVE 
	beta_events_6 ~ gamma(4,3);
	for(ii in 1:J_events_6){
		cut_events_6[ii,] ~ normal(0, 4);
	}
	
	for(ii in 1:N_events_6){
		y_events_6[ii] ~ ordered_logistic((-beta_events_6[item_events_id_6[ii]]) * theta[latent_events_id_6[ii]], 
											cut_events_6[item_events_id_6[ii],]) ;
	}
	

	/////////////////////////
	// count info is below
	/////////////////////////
	/// COUNT INF IS NEGTIVE 

	beta_events_C_zinb ~ gamma(4, 3);
	alpha_events_C_zinb ~ normal(0, 4);
	beta_events_C_pos ~ gamma(4, 3);
	alpha_events_C_pos ~ normal(0, 4);
	r ~ gamma(1, .5);
	
	{
		real x_pos;

		for(ii in 1:N_events_C){
			x_pos = alpha_events_C_pos + beta_events_C_pos 
				* theta[latent_events_id_C[ii]];
			if(y_events_C[ii] == 0){
				target += log_sum_exp(bernoulli_logit_lpmf(1 | x_pos), 
							bernoulli_logit_lpmf(0 | x_pos) +
							neg_binomial_2_log_lpmf(y_events_C[ii] | 
							alpha_events_C_zinb - 
							beta_events_C_zinb * theta[latent_events_id_C[ii]], 
							r));
			} else {
				target += bernoulli_logit_lpmf(0 | x_pos) +
						neg_binomial_2_log_lpmf(y_events_C[ii] | 
						alpha_events_C_zinb - 
						beta_events_C_zinb * theta[latent_events_id_C[ii]], 
						r);
			}
		}
	}

}


generated quantities {

	/// for log likelihood
	vector[N_disap] ll_disap;
	vector[N_kill] ll_kill;
	vector[N_tort] ll_tort;
	vector[N_amnesty] ll_amnesty;
	vector[N_state] ll_state; 
	vector[N_hrw] ll_hrw;
	vector[N_hathaway] ll_hathaway;
	vector[N_events_2] ll_events_2;
	vector[N_events_3] ll_events_3;
	vector[N_events_6] ll_events_6;
	vector[N_events_C] ll_events_C;


	
	for(ii in 1:N_disap){
		ll_disap[ii] = ordered_logistic_lpmf(y_disap[ii] | (beta_disap) * theta[latent_disap_id[ii]], 
						to_vector(cut_disap[year_disap_id[ii] - min_year_disap + 1,] )) ;
	}
	
	
	for(ii in 1:N_kill){
		ll_kill[ii] = ordered_logistic_lpmf(y_kill[ii] | (beta_kill) * theta[latent_kill_id[ii]], 
						to_vector(cut_kill[year_kill_id[ii] - min_year_kill + 1,] )) ;
	}
	
		
	for(ii in 1:N_tort){
		ll_tort[ii] = ordered_logistic_lpmf(y_tort[ii] | (beta_tort) * theta[latent_tort_id[ii]], 
						to_vector(cut_tort[year_tort_id[ii] - min_year_tort + 1,] )) ;
	}

		
	for(ii in 1:N_amnesty){
		ll_amnesty[ii] = ordered_logistic_lpmf(y_amnesty[ii] | (-beta_amnesty) * theta[latent_amnesty_id[ii]], 
						to_vector(cut_amnesty[year_amnesty_id[ii] - min_year_amnesty + 1,] )) ;
	}
	

	for(ii in 1:N_state){
		ll_state[ii] = ordered_logistic_lpmf(y_state[ii] | (-beta_state) * theta[latent_state_id[ii]], 
						to_vector(cut_state[year_state_id[ii] - min_year_state + 1,] )) ;
	}
	
		
	for(ii in 1:N_hrw){
		ll_hrw[ii] = ordered_logistic_lpmf(y_hrw[ii] | (-beta_hrw) * theta[latent_hrw_id[ii]], 
						to_vector(cut_hrw[year_hrw_id[ii] - min_year_hrw + 1,] )) ;
	}

	for(ii in 1:N_hathaway){
		ll_hathaway[ii] = ordered_logistic_lpmf(y_hathaway[ii] | (-beta_hathaway) * theta[latent_hathaway_id[ii]], 
						to_vector(cut_hathaway[year_hathaway_id[ii] - min_year_hathaway + 1,] )) ;
	}
	
	for(ii in 1:N_events_2){
		ll_events_2[ii] = bernoulli_logit_lpmf(y_events_2[ii] | alpha_events_2[item_events_id_2[ii]] - beta_events_2[item_events_id_2[ii]] * theta[latent_events_id_2[ii]] );

	}

	
	for(ii in 1:N_events_3){
		ll_events_3[ii] = ordered_logistic_lpmf(y_events_3[ii] | (beta_events_3[item_events_id_3[ii]]) * theta[latent_events_id_3[ii]], 
											cut_events_3[item_events_id_3[ii],]) ;
	}	 
	 
	 
	
	for(ii in 1:N_events_6){
		ll_events_6[ii] = ordered_logistic_lpmf(y_events_6[ii] | (-beta_events_6[item_events_id_6[ii]]) * theta[latent_events_id_6[ii]], 
											cut_events_6[item_events_id_6[ii],]) ;
	}
	

	
	{
		real x_pos;

		for(ii in 1:N_events_C){
			x_pos = alpha_events_C_pos + beta_events_C_pos 
				* theta[latent_events_id_C[ii]];
			if(y_events_C[ii] == 0){
				ll_events_C[ii] = log_sum_exp(bernoulli_logit_lpmf(1 | x_pos), 
							bernoulli_logit_lpmf(0 | x_pos) +
							neg_binomial_2_log_lpmf(y_events_C[ii] | 
							alpha_events_C_zinb - 
							beta_events_C_zinb * theta[latent_events_id_C[ii]], 
							r));
			} else {
				ll_events_C[ii] = bernoulli_logit_lpmf(0 | x_pos) +
						neg_binomial_2_log_lpmf(y_events_C[ii] | 
						alpha_events_C_zinb - 
						beta_events_C_zinb * theta[latent_events_id_C[ii]], 
						r);
			}
		}
	}
	

	
	

}
