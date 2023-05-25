f = 50;                 % Freq of the signal
Fs = 5*f;               % Sampling freq
number_of_cycles = 500; % Number of cycles of wave
n = (0:1/Fs:number_of_cycles/f);    % Generate n vector
L = max(size(n));
noise_factor = 10;
A = 100;
B = 10;

beta = 0.5;
f2 = 5;

random_part = randn(1, L)*0.9;
for i=2:L
    random_part(i) = random_part(i) + random_part(i-1);
end

sin_signal_linear = sin(2*pi*f*n).*(A+B*n);
sin_signal_periodic = sin(2*pi*f*n).*(beta*sin(2*pi*f2*n) + 1);
sin_signal_random = sin(2*pi*f*n).*random_part;

N = 2*L;   % Will do NFFT where N > L



sin_spectrum_linear = fft_plot(sin_signal_linear, N);
sin_spectrum_periodic = fft_plot(sin_signal_periodic, N);
sin_spectrum_random = fft_plot(sin_signal_random, N);


f = Fs*(0:N/2-1)/N;

subplot(3, 1, 1);
plot(f, sin_spectrum_linear)
xlim([40 60])
title('An = 100 + 10n')

subplot(3, 1, 2);
plot(f, sin_spectrum_periodic)
xlim([40 60])
title('A = 1 + 0.5sin(2pi*5)')

subplot(3, 1, 3);
plot(f, sin_spectrum_random)
xlim([40 60])
title('An = An-1 + noise')

