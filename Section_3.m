% Specify parameters
N = 100; % number of observations
theta_true = [10; 2]; % true values of theta_1 and theta_2
sigma_e = 2; % standard deviation of the noise
sigma_theta = [1 10 100]; % standard deviations of the prior distribution for theta

% Generate data for each model
y1 = sigma_e * randn(N,1); % M1: y = e
y2 = theta_true(1) + sigma_e * randn(N,1); % M2: y = theta_1 + e
y3 = [ones(N,1), (1:N)'] * theta_true + sigma_e * randn(N,1); % M3: y = theta_1 + theta_2*n + e

% Function to compute BIC
compute_bic = @(y, X, theta_hat) N*log(sum((y - X*theta_hat).^2)/N) + size(X,2)*log(N);

% Compute BIC for each model
bic1 = compute_bic(y1, ones(N,1), mean(y1)); % M1
bic2 = compute_bic(y2, ones(N,1), mean(y2)); % M2
bic3 = compute_bic(y3, [ones(N,1), (1:N)'], inv([ones(N,1), (1:N)']' * [ones(N,1), (1:N)']) * [ones(N,1), (1:N)']' * y3); % M3

% Print BICs
fprintf('BIC for M1: %.2f\n', bic1);
fprintf('BIC for M2: %.2f\n', bic2);
fprintf('BIC for M3: %.2f\n', bic3);
