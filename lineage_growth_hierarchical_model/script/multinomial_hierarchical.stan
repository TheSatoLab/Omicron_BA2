

data {
  int K;
  int N;
  int D;
  int bin_size;
  real generation_time;
  vector[N] X;
  int Y[N,K];
  int country[N];
  int Y_sum[N];
}

transformed data {
  vector[D] Zeros;
  real Max_date;
  vector[N] X_norm;
    Zeros = rep_vector(0,D);
  Max_date = X[N];
  for (n in 1:N) {
    X_norm[n] = X[n] / Max_date;
  }
}

parameters {
  matrix[D,K-1] b0_raw;
  matrix[D,K-1] b1_raw;
  vector[K-1] b1_raw_mean;
  vector<lower=0>[K-1] b1_raw_sigma;
}

transformed parameters {
  matrix[D,K] b0;
  matrix[D,K] b1;
  matrix[N,K] mu;

  b0 = append_col(Zeros, b0_raw);
  b1 = append_col(Zeros, b1_raw);

  for(k in 1:K) {
    for(n in 1:N) {
      mu[n,k] = b0[country[n],k] + b1[country[n],k] * X_norm[n];      
    }
  }

}

model {
  for (d in 1:D){
    b1_raw[d,] ~ student_t(6,b1_raw_mean,b1_raw_sigma);
  }

  for (n in 1:N)
    Y[n,] ~ multinomial_logit(mu[n,]');
}

generated quantities {
  vector[K-1] growth_rate_mean;
  matrix[D,K-1] growth_rate;
  matrix[N,K] theta;
  int Y_predict[N,K];
  
  for(k in 1:(K-1)){
      growth_rate_mean[k] = exp(((b1_raw_mean[k] / Max_date) / bin_size)  * generation_time);
  }
  
  for(k in 1:(K-1)){
    for(d in 1:D){
      growth_rate[d,k] = exp(((b1_raw[d,k] / Max_date) / bin_size)  * generation_time);
    }
  }  

  for(n in 1:N){
    theta[n,] = softmax(mu[n,]')';
    Y_predict[n,] = multinomial_rng(softmax(mu[n,]'),Y_sum[n]);
  }

}

