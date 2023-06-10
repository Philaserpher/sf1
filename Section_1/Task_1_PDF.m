% Constants
mu_prior = 12; % set your prior mean
var_prior = 0.05; % set your prior variance
var_noise = 2; % set your noise variance
real_val = 10;
N = 10; % number of data points

% Generate some data
yn = real_val + sqrt(var_noise)*randn(N,1); 

% Prior Distribution
theta_range = linspace(8, 18, 10000);
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

