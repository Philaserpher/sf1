% Load data
load('hidden_data.mat');
sigma_theta = 2;
sigma_n = 1;

% Prior parameters
mu0 = 0;
Sigma0 = sigma_theta^2;
sigma_n_sq = sigma_n^2;

% Length and content of the signal
L = 15;
signal=[-3 5 -2 4 1 3 5 -1 2 4 6 5 -2 -2 1];

% Number of data points
N = length(y);

% Initialize evidence array
log_evidence = zeros(N-L+1, 1);
theta_post = zeros(N-L+1, 1);

% Iterate over possible offsets
for offset = 1:(N-L+1)
    % Construct G matrix
    G = zeros(N, 1);
    G(offset:offset+L-1) = signal;  % Here we incorporate the signal shape into the G matrix
    
    % Calculate posterior mean and variance for theta
    Sigma_post = 1/(1/Sigma0 + G' * G / sigma_n_sq);
    mu_post = Sigma_post * G' * y / sigma_n_sq;
    
    % Store posterior mean of theta
    theta_post(offset) = mu_post;
    
    % Calculate log-evidence for this offset and store
    log_evidence(offset) = log(sqrt(Sigma_post/(2*pi*sigma_n_sq))) - ...
        0.5 * (y' * y - 2 * mu_post * G' * y + mu_post^2 * G' * G) / sigma_n_sq;
end

% Find most probable offset and its corresponding theta
[max_log_evidence, most_prob_offset] = max(log_evidence);
most_prob_theta = theta_post(most_prob_offset);

% Compute posterior probabilities for offset
posterior_prob_offset = exp(log_evidence - max_log_evidence);
posterior_prob_offset = posterior_prob_offset / sum(posterior_prob_offset);

% Plot posterior probabilities for offset
figure;
plot(posterior_prob_offset);
xlabel('Offset');
ylabel('Posterior Probability');
title('Posterior Probabilities for Offset');


