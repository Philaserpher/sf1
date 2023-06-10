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

