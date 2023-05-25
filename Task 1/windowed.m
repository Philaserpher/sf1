f = 50;                 % Freq of the signal
Fs = 5*f;               % Sampling freq
number_of_cycles = 40000; % Number of cycles of wave
n = (0:1/Fs:number_of_cycles/f);    % Generate n vector
L = max(size(n));
W = 500;                % Window size


rect_win = [rectwin(W)' zeros(1, L-W)];             % Rectangular
bartlett_win = [bartlett(W)' zeros(1, L-W)];        % Triangular
hamming_win = [hamming(W)' zeros(1, L-W)];          % Hamming
chebyshev_win = [chebwin(W)' zeros(1, L-W)];        % Chebyshev


sin_signal = sin(2*pi*f*n).*rect_win;
cos_signal = cos(2*pi*f*n).*bartlett_win;
exp_signal = exp(1i*2*pi*f*n).*hamming_win;
extra_signal = exp(1i*2*pi*f*n).*chebyshev_win;

N = 10*L;   % Will do NFFT where N > L



sin_spectrum = fft_plot(sin_signal, N);
cos_spectrum = fft_plot(cos_signal, N);
exp_spectrum = fft_plot(exp_signal, N);
extra_spectrum = fft_plot(extra_signal, N);

f = Fs*(0:N/2-1)/N;

subplot(2, 2, 1);
plot(f, sin_spectrum)
title('Rectangular')
xlim([46 54])

subplot(2, 2, 2);
plot(f, cos_spectrum)
title('Bartlett')
xlim([46 54])

subplot(2, 2, 3);
plot(f, exp_spectrum)
title('Hamming')
xlim([46 54])

subplot(2, 2, 4);
plot(f, extra_spectrum)
title('Chebyshev')
xlim([46 54])