f = 50;                 % Freq of the signal
Fs = 5*f;               % Sampling freq
number_of_cycles = 40000; % Number of cycles of wave
n = (0:1/Fs:number_of_cycles/f);    % Generate n vector
L = max(size(n));
W = 500;                % Window size


rect_win = [rectwin(W)' zeros(1, L-W)];             % Rectangular
bartlett_win = [bartlett(W)' zeros(1, L-W)];        % Triangular
hamming_win = [hamming(W)' zeros(1, L-W)];          % Hamming


sin_signal = sin(2*pi*f*n).*rect_win;
cos_signal = cos(2*pi*f*n).*bartlett_win;
exp_signal = exp(1i*2*pi*f*n).*hamming_win;

N = 10*L;   % Will do NFFT where N > L



sin_spectrum = fft_plot(sin_signal, N);
cos_spectrum = fft_plot(cos_signal, N);
exp_spectrum = fft_plot(exp_signal, N);

f = Fs*(0:N/2-1)/N;

subplot(3, 1, 1);
plot(f, sin_spectrum)
xlim([40 60])

subplot(3, 1, 2);
plot(f, cos_spectrum)
xlim([40 60])

subplot(3, 1, 3);
plot(f, exp_spectrum)
xlim([40 60])