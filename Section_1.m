% Specify parameters
N = 100;   % number of observations
theta_true = 10; % true value of theta
sigma_e = 2; % standard deviation of the noise

% Generate data
e = sigma_e * randn(N,1); % Gaussian noise
y = theta_true + e; % observations

% Maximum Likelihood estimation
theta_ML = mean(y);

% Bayesian estimation
sigma_prior = [1 10 100]; % standard deviations of the prior distribution
theta_Bayes = zeros(1, length(sigma_prior));
for i = 1:length(sigma_prior)
    % Posterior distribution is proportional to: exp(-1/(2*sigma_e^2)*(y-theta)^2) * exp(-1/(2*sigma_prior(i)^2)*theta^2)
    % This is a Gaussian distribution with mean = sigma_e^2 / (N*sigma_e^2 + sigma_prior(i)^2) * sum(y)
    % and variance = sigma_e^2 * sigma_prior(i)^2 / (N*sigma_e^2 + sigma_prior(i)^2)
    theta_Bayes(i) = sigma_e^2 / (N*sigma_e^2 + sigma_prior(i)^2) * sum(y);
end

% Print results
fprintf('True theta: %.2f\n', theta_true);
fprintf('ML estimate of theta: %.2f\n', theta_ML);
for i = 1:length(sigma_prior)
    fprintf('Bayesian estimate of theta (sigma_prior = %.2f): %.2f\n', sigma_prior(i), theta_Bayes(i));
end
