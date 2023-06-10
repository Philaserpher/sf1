N = 5;
P = 2;
x = generate_linear(N, P, [1; 1]);
G = zeros(N, P);
for n = 1:N
    G(n, :) = [1, n];
end

% ML estimator
theta_ml = (G'*G) \ (G'*x);

% Prior parameters
s0 = 1000;
mu0 = zeros(P, 1);
Sigma0 = s0 * eye(P);

% Bayesian estimator
Sigma_post = inv(inv(Sigma0) + G'*G);
mu_post = Sigma_post * (inv(Sigma0)*mu0 + G'*x);

% Plot parameters
[X,Y] = meshgrid(0:0.01:5, 0:0.0001:2); % adjust these values based on your domain
pos = [X(:) Y(:)];

% Calculate posterior probability density function
Z = mvnpdf(pos, mu_post', Sigma_post);

% Convert Z back into a matrix for plotting
Z = reshape(Z, size(X));

% Plot
figure;
contourf(X, Y, Z);
xlabel('theta1');
ylabel('theta2');
colorbar; % Adds a color scale
title('Posterior probability density');



