theta_true = 10; % true value of theta

% Create a range for values of N
N_values = 1:1:100; % range of N values
% store the estimates in arrays (initialise to 0)
theta_ML_N = zeros(1, length(N_values));
theta_Bayes_N = zeros(1, length(N_values));

% use index because the step size in N is variable
index = 1;

% standard deviation of the noise
sigma_err = 1; 

for N = N_values

    % make noise and signal
    err = sigma_err * randn(N,1);
    y = theta_true + err; 

    % ML is just mean
    theta_ML_N(index) = mean(y);

    % Bayesian estimation with sigma_prior = 1
    sigma_prior = 1;
    theta_Bayes_N(index) = sigma_err^2 / (N*sigma_err^2 + sigma_prior^2) * sum(y);
    
    index = index + 1;
end

% Generate estimates for different sigma_prior
sigma_prior_values = 0.1:0.1:100; % range of sigma_prior values
theta_Bayes_sigma_prior = zeros(1, length(sigma_prior_values)); % array to save Bayesian estimates

% Fix N to 100 for sigma_prior plot
N = 100;
% Generate data
sigma_err = 1; % standard deviation of the noise
err = sigma_err * randn(N,1); % Gaussian noise
y = theta_true + err; % observations

for i = 1:length(sigma_prior_values)
    sigma_prior = sigma_prior_values(i);
    theta_Bayes_sigma_prior(i) = sigma_err^2 / (N*sigma_err^2 + sigma_prior^2) * sum(y);
end

% Generate estimates for different sigma_err
sigma_err_values = 0.1:0.1:10; % range of sigma_err values
theta_Bayes_sigma_err = zeros(1, length(sigma_err_values)); % array to save Bayesian estimates

% Generate data
for i = 1:length(sigma_err_values)
    sigma_err = sigma_err_values(i);
    err = sigma_err * randn(N,1); % Gaussian noise
    y = theta_true + err; % observations

    % Bayesian estimation with sigma_prior = 1
    sigma_prior = 1;
    theta_Bayes_sigma_err(i) = sigma_err^2 / (N*sigma_err^2 + sigma_prior^2) * sum(y);
end

% Plot results
figure;
subplot(3,1,1);
plot(N_values, theta_ML_N, 'r', N_values, theta_Bayes_N, 'b');
xlabel('N');
ylabel('Estimate');
legend('ML', 'Bayes');
title('Estimate vs N');

subplot(3,1,2);
plot(sigma_prior_values, theta_Bayes_sigma_prior, 'b');
xlabel('sigma_prior');
ylabel('Bayesian Estimate');
title('Bayesian Estimate vs sigma prior');

subplot(3,1,3);
plot(sigma_err_values, theta_Bayes_sigma_err, 'b');
xlabel('sigma_err');
ylabel('Bayesian Estimate');
title('Bayesian Estimate vs sigma err');

% Constants
mu_prior = 12; % set your prior mean
var_prior = 2; % set your prior variance
var_noise = 1; % set your noise variance
real_val = 10;
N = 10; % number of data points

% Generate some data
yn = real_val + sqrt(var_noise)*randn(N,1); 

% Prior Distribution
theta_range = linspace(mu_prior-3*sqrt(var_prior), mu_prior+3*sqrt(var_prior), 1000);
prior = normpdf(theta_range, mu_prior, sqrt(var_prior));

% Likelihood
log_likelihood = sum(log(normpdf(yn, theta_range, sqrt(var_noise))), 1);
likelihood = exp(log_likelihood - max(log_likelihood));  % shift values to avoid underflow
likelihood = likelihood / trapz(theta_range, likelihood);  % normalize to form a proper distribution

% Posterior Distribution
mu_post = (mu_prior/var_prior + sum(yn)/var_noise)/(1/var_prior + N/var_noise);
var_post = 1/(1/var_prior + N/var_noise);
posterior = normpdf(theta_range, mu_post, sqrt(var_post));

% Plotting
figure
plot(theta_range, prior, 'LineWidth', 2)
hold on
plot(theta_range, likelihood, 'LineWidth', 2)
plot(theta_range, posterior, 'LineWidth', 2)
legend('Prior', 'Likelihood', 'Posterior')
xlabel('\theta')
ylabel('Density')
grid on

