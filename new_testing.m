read = "Sounds/500hz-107658.wav";
%read = "Sounds/organ.wav";
[signal,Fs] = audioread(read);


N = 1000;

    

fft_spect = fft(signal, N);
fft_spect_onesided = abs(fft_spect(1:N/2))/(N/2);
f = Fs*(0:N/2-1)/N;

dft_spect = DFT_manual(signal, N);
dft_spect_onesided = abs(dft_spect(1:N/2))/(N/2);



hold on
plot(f, fft_spect_onesided)
xlabel('Frequency(Hz)') 
ylabel('Magnitude') 
plot(f, dft_spect_onesided)
legend('FFT', 'DFT');
xlim([0 1000])
title('Comparison between FFT and DFT')
hold off