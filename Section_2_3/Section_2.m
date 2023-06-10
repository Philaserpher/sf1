% Specify parameters
N = 100; % number of observations
theta_true = [10; 2]; % true values of theta_1 (DC level) and theta_2 (trend)
sigma_e = 2; % standard deviation of the noise

% Generate data
e = sigma_e * randn(N,1); % Gaussian noise
X = [ones(N,1), (1:N)']; % design matrix
y = X * theta_true + e; % observations

% Maximum Likelihood estimation
theta_ML = inv(X' * X) * X' * y;

% Bayesian estimation
sigma_prior = [1 10 100]; % standard deviations of the prior distribution
theta_Bayes = zeros(length(sigma_prior), size(theta_true,1));
for j = 1:length(sigma_prior)
    for i = 1:size(theta_true,1)
        % Posterior distribution is proportional to: exp(-1/(2*sigma_e^2)*(y-X*theta)^2) * exp(-1/(2*sigma_prior(j)^2)*theta^2)
        % This is a Gaussian distribution with mean = sigma_e^2 / (N*sigma_e^2 + sigma_prior(j)^2) * X' * y
        % and variance = sigma_e^2 * sigma_prior(j)^2 / (N*sigma_e^2 + sigma_prior(j)^2)
        theta_Bayes(j, i) = sigma_e^2 / (N*sigma_e^2 + sigma_prior(j)^2) * X(:,i)' * y;
    end
end

% Print results
fprintf('True theta: %.2f %.2f\n', theta_true(1), theta_true(2));
fprintf('ML estimate of theta: %.2f %.2f\n', theta_ML(1), theta_ML(2));
for j = 1:length(sigma_prior)
    fprintf('Bayesian estimate of theta (sigma_prior = %.2f): %.2f %.2f\n', sigma_prior(j), theta_Bayes(j, 1), theta_Bayes(j, 2));
end
