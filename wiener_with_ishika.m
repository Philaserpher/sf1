%read = 'Sounds/piano_clean_note4.wav';
%read = 'Sounds/letter_t.wav';
%read = 'Sounds/organ.wav';
%read = 'Sounds/piano_clean.wav';
%read = "Sounds/500hz-107658.wav";
read = "Sounds/ishika_talking.wav";


[x_in_noiseless, Fs] = audioread(read);
x_in_noiseless = x_in_noiseless(:,1);
L = max(size(x_in_noiseless));

x_in_noiseless = x_in_noiseless.';

% Set up our noisy signal as x_in
noise_factor = 0.01;
T = 1/Fs;
t = 0:T:L*T-T;
noise = noise_factor*randn(1, L);
x_in = x_in_noiseless + noise;
y_out = 0 * x_in;

% N and overlap
N = 2^15;
overlap = N/2;

% Partition data into samples size N overlapping by overlap
x = buffer(x_in, N, overlap);

% Get dimensions
[N_samps, N_frames] = size(x);

% Extends Hann filter array and times by x
x_w = repmat(hanning(N), 1, N_frames) .* x;

% Define the noise power spectrum
noise_power_spectrum = abs(fft(noise)).^2;

y_w = zeros(N, N_frames-2);  % Initialize y_w with appropriate size

X_w = zeros(N, N_frames - 2);

for frame_no = 1:N_frames-2
    % Convert items in next frame to frequency domain
    X_w(:, frame_no) = fft(x_w(:, frame_no));
    
    % Estimate the power spectrum of the clean signal using Wiener filter
    clean_power_spectrum = abs(X_w(:, frame_no)).^2 - noise_power_spectrum(:, frame_no);
    clean_power_spectrum = max(clean_power_spectrum, 0); % Ensure non-negativity
    
    % Apply Wiener filter to obtain the estimated clean signal spectrum
    estimated_clean_spectrum = X_w(:, frame_no) .* (clean_power_spectrum ./ (clean_power_spectrum + noise_power_spectrum(:, frame_no)));
    
    % Set the phase of the estimated clean signal spectrum same as the original signal
    estimated_clean_spectrum = abs(estimated_clean_spectrum) .* exp(1i * angle(X_w(:, frame_no)));
    
    % Convert the estimated clean spectrum back to time domain
    y_w(:, frame_no) = ifft(estimated_clean_spectrum);
end

% Overlap and add to the output signal
for frame_no = 1:N_frames-2
    y_out((frame_no-1)*overlap+1:(frame_no-1)*overlap+N) = ...
        y_out((frame_no-1)*overlap+1:(frame_no-1)*overlap+N) + y_w(:, frame_no)';
end

% Plot the original signal, noisy signal, and processed output
subplot(3, 1, 1);
plot(t, x_in_noiseless);
title('Original Signal');

subplot(3, 1, 2);
plot(t, x_in);
title('Noisy Signal');

subplot(3, 1, 3);
plot(t, real(y_out));
title('Processed Output');

% Compute the frequency axis

freq = (0:L/2) * (Fs/L);

% Compute the spectra of the original, noisy, and processed signals
X_in_noiseless = fft_prep_plot(fft(x_in_noiseless), L);
X_in = fft_prep_plot(fft(x_in), L);
Y_out = fft_prep_plot(fft(y_out), L);

% Plot the frequency domain representation
figure;
subplot(3, 1, 1);
plot(freq, abs(X_in_noiseless));
title('Original Signal Spectrum');
xlabel('Frequency');
ylabel('Magnitude');


subplot(3, 1, 2);
plot(freq, abs(X_in));
title('Noisy Signal Spectrum');
xlabel('Frequency');
ylabel('Magnitude');


subplot(3, 1, 3);
plot(freq, abs(Y_out));
title('Processed Output Spectrum');
xlabel('Frequency');
ylabel('Magnitude');

sound(real(x_in), Fs)
pause(L*T + 1)
sound(real(y_out), Fs)

