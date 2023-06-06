% Make frequency vector
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


% Play the sounds
sound(real(x_in), Fs)
pause(L*T + 1)
sound(real(y_out), Fs)

% Export files
audiowrite("Sounds\ishika_talking2_noise.wav", x_in, Fs)
audiowrite("Sounds\ishika_talking2_filtered.wav", y_out, Fs)
