% specify parameters
N = 10000;  % number of data points
max_P = 15;  % maximum order to examine
repetitions = 100;  % number of repetitions for each order

sigma_e = 1;  % standard deviation of noise

MSE = zeros(max_P, 1);  % Mean Squared Error for each order

for P = 1:max_P
    MSE_temp = zeros(repetitions, 1);  % temporary storage for MSE in each repetition
    for r = 1:repetitions
        % generate AR(P) process
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

        % specify prior for Bayesian estimation
        mu_prior = theta_true;
        Sigma_prior = eye(P);  % covariance of prior

        % Bayesian estimation
        Sigma_posterior = inv(inv(Sigma_prior) + G' * G / sigma_e^2);
        mu_posterior = Sigma_posterior * (inv(Sigma_prior) * mu_prior + G' * x / sigma_e^2);
        theta_bayesian = mu_posterior;

        % residuals for Bayesian estimate
        residuals_bayesian = x - G * theta_bayesian;
        MSE_temp(r) = mean(residuals_bayesian.^2);  % Mean Squared Error for this repetition
    end
    MSE(P) = mean(MSE_temp);  % Average MSE over all repetitions
end

% Plot the mean squared error for each order
figure; plot(1:max_P, MSE); xlabel('Order'); ylabel('Mean Squared Error');
