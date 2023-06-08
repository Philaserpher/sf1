N = 1000;  % number of data points

% AR(2) coefficients
theta = [0.5, 1.3]';  % Modify these parameters to check the stability of the model

% generate noise
e = randn(N, 1);

% Generate AR(2) process
x = zeros(N, 1);
for t = 3:N
    x(t) = theta(1)*x(t-1) + theta(2)*x(t-2) + e(t);
end

% Compute and plot magnitude squared of the one-sided DFT of the data
X = fft(x);
X_one_sided = X(1:N/2);
magnitude_squared_one_sided = abs(X_one_sided).^2 / N;

figure;
plot(magnitude_squared_one_sided);
xlabel('Frequency');
ylabel('Magnitude Squared');
title('Magnitude Squared of the One-sided DFT of the Data');

figure;
plot(x);
xlabel('Time');
ylabel('Amplitude');
title('AR(2) Process');
