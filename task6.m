%read = 'Sounds/piano_clean_note4.wav';
%read = 'Sounds/letter_t.wav';
read = 'Sounds/organ.wav';

[signal, Fs] = audioread(read);
L = max(size(signal));

N = 2*L;



fft_spect = fft(signal, N);
fft_spect_onesided = abs(fft_spect(1:N/2))/(N/2);
f = Fs*(0:N/2-1)/N;

plot(f, fft_spect_onesided)
xlabel('Frequency(Hz)')
ylabel('Magnitude')
xlim([0 8000])
