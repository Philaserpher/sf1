% Set up our noisy signal as x_in
len = 10000;
t = (1:len);
x_in_noiseless = 0.5*cos(t*pi/4) + sin(t*pi/100);
x_in = x_in_noiseless + randn(1, len);
y_out = zeros(1, len);

% N and overlap
N = 512;
overlap = 256;
%
% Partition data into samples size N overlapping by overlap
x = buffer(x_in, N, overlap);

% Get dimensions
[N_samps, N_frames] = size(x);

% Wiener filter parameters
noisePSD = zeros(N, 1);  % Initialize noise power spectral density
alpha = 0.99;  % Smoothing factor for noise power estimation

for frame_no = 1:N_frames
    % Convert current frame to frequency domain
    X = fft(x(:, frame_no));
    
    % Estimate noise power spectral density
    noisePSD = alpha * noisePSD + (1 - alpha) * abs(X).^2;
    
    % Wiener filter
    X_den = X .* conj(X) ./ (abs(X).^2 + noisePSD);
    
    % Inverse STFT: Convert denoised frame back to the time domain
    x_den = real(ifft(X_den));
    
    % Overlap-add the denoised frame
    start_idx = (frame_no-1)*overlap+1;
    end_idx = start_idx + N - 1;
    y_out(start_idx:end_idx) = y_out(start_idx:end_idx) + x_den.';
end

% Plot the original, noisy, and denoised signals
hold on;
plot(t, x_in_noiseless, 'g');
plot(t, x_in, 'r');
plot(t, y_out, 'b');
legend('Original', 'Noisy', 'Denoised');
xlabel('t');
ylabel('Amplitude');
title('Original, Noisy, and Denoised Signals');
hold off;


