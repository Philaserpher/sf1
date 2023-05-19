f = 50;                 % Freq of the signal
Fs = 5*f;               % Sampling freq
number_of_cycles = 40000; % Number of cycles of wave
n = (0:1/Fs:number_of_cycles/f);    % Generate n vector
L = max(size(n));
noise_factor = 10;

sin_signal = sin(2*pi*f*n) + randn(1, L)*noise_factor;

N = 10*L;   % Will do NFFT where N > L



sin_spectrum = fft_plot(sin_signal, N);


f = Fs*(0:N/2-1)/N;

subplot(1, 1, 1);
plot(f, sin_spectrum)
