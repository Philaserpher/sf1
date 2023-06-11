% specify parameters
N = 10;  % number of data points
P = 4;  % order of the AR process
sigma_e = 1;  % standard deviation of noise

% generate AR(P) process
%theta_true = randn(P, 1);  % true parameters
theta_true = zeros(P, 1);
for n = 1:P
    theta_true(n) = 2^(-n);
end

x = zeros(N, 1);  % initial values
x(1:P) = randn(P, 1);
for n = (P+1):N
    x(n) = x((n-P):(n-1))' * theta_true + sigma_e * randn;
end

% create G matrix
G = zeros(N, P);
for n = (P+1):N
    G(n, :) = x((n-P):(n-1));
end

% ML estimation
theta_ml = pinv(G) * x;

% specify prior for Bayesian estimation
%mu_prior = zeros(P, 1);  % mean of prior
mu_prior = theta_true;
Sigma_prior = eye(P);  % covariance of prior

% Bayesian estimation
Sigma_posterior = inv(inv(Sigma_prior) + G' * G / sigma_e^2);
mu_posterior = Sigma_posterior * (inv(Sigma_prior) * mu_prior + G' * x / sigma_e^2);
theta_bayesian = mu_posterior;

% display results
fprintf('True parameters: \n');
disp(theta_true);
fprintf('ML estimate: \n');
disp(theta_ml);
fprintf('Bayesian estimate: \n');
disp(theta_bayesian);
