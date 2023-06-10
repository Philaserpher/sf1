% MATLAB Code

% Specify parameters
N = 100; % number of observations

% Define the true parameters
theta_true = [1; 2; 3]; % For example

% Initialize G and y
G = zeros(N, length(theta_true));
y = zeros(N, length(theta_true));

% Define functions
% Now each function includes all parameters in theta_true
f1 = @(n) [1, 0, 0]; % Function 1: yn = θ1
f2 = @(n) [1, n, n^2]; % Function 2: yn = θ1 + θ2*n + θ3*n^2
functions = {f1, f2};

% Generate data
for n = 1:N
    % Generate observations for each function
    for i = 1:length(functions)
        fn = functions{i};
        G(i, :) = fn(n);
        y(i, n) = G(i, :) * theta_true + randn(); % Noise for each function and each datapoint
    end
end

% Now you can perform estimation with y and G
% For example, we can solve the normal equations to estimate theta
theta_est = (G*G') \ (G*y');

fprintf('True theta: \n');
disp(theta_true);
fprintf('Estimated theta: \n');
disp(theta_est);
