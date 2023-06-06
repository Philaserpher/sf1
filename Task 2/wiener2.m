read = "Sounds/ishika_talking2.wav";

% Load file
[x_in_noiseless, Fs] = audioread(read);
x_in_noiseless = x_in_noiseless(:,1);
L = max(size(x_in_noiseless));

% Change dimensions
x_in_noiseless = x_in_noiseless.';

% Set up our noisy signal as x_in
noise_factor = 0.01;
T = 1/Fs;
t = 0:T:L*T-T;
noise = noise_factor*randn(1, L);
x_in = x_in_noiseless + noise;
y_out = 0 * x_in;

% N and overlap
N = 2^13;
overlap = N/2;

% Partition data into samples size N overlapping by overlap
x = buffer(x_in, N, overlap);

% Get dimensions
[N_samps, N_frames] = size(x);

% Extends Hann filter array and applies to x
x_w = repmat(hanning(N), 1, N_frames) .* x;

% Define the noise power spectrum
noise_power_spectrum = abs(fft(noise)).^2;

% Initialize y_w and X_w with appropriate size
y_w = zeros(N, N_frames - 2);  
X_w = zeros(N, N_frames - 2);

for frame_no = 1:N_frames-2
    % Convert items in next frame to frequency domain
    X_w(:, frame_no) = fft(x_w(:, frame_no));
    
    % Estimate the power spectrum of the clean signal using Wiener filter
    clean_power_spectrum = abs(X_w(:, frame_no)).^2 - noise_power_spectrum(:, frame_no);
