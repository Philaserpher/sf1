%read = 'Sounds/piano_clean_note4.wav';
read = 'Sounds/letter_t.wav';
%read = 'Sounds/organ.wav';

[signal, Fs] = audioread(read);
L = max(size(signal));
N = L;   % Will do NFFT where N > L
W = N;



rect_win = rectwin(W)';             % Rectangular
taylor_win = taylorwin(W)';        % Triangular
hamming_win = hamming(W)';          % Hamming
chebyshev_win = chebwin(W)';        % Chebyshev


sin_signal = signal.*rect_win;
cos_signal = signal.*taylor_win;
exp_signal = signal.*hamming_win;
extra_signal = signal.*chebyshev_win;





sin_spectrum = fft_plot(sin_signal, N);
cos_spectrum = fft_plot(cos_signal, N);
exp_spectrum = fft_plot(exp_signal, N);
extra_spectrum = fft_plot(extra_signal, N);

f = Fs*(0:N/2-1)/N;

subplot(2, 2, 1);
plot(f, sin_spectrum)
title('Rectangular')
xlim([0 8000])

subplot(2, 2, 2);
plot(f, cos_spectrum)
title('Taylor')
xlim([0 8000])

subplot(2, 2, 3);
plot(f, exp_spectrum)
title('Hamming')
xlim([0 8000])

subplot(2, 2, 4);
plot(f, extra_spectrum)
title('Chebyshev')
xlim([0 8000])
