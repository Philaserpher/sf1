%read = "Sounds/500hz-107658.wav";
read = "Sounds/organ.wav";
[signal,Fs] = audioread(read);

N = 50;



fft_spect = fft(signal, N);
dft_spect = DFT_manual(signal, N);

P2 = abs(fft_spect/N);
fft_spect = P2(1:N/2+1);
fft_spect(2:end-1) = 2*fft_spect(2:end-1);
fft_spect = fft_spect.';

P2 = abs(dft_spect/N);
dft_spect = P2(1:N/2+1);
dft_spect(2:end-1) = 2*dft_spect(2:end-1);

f = Fs*(0:(N/2))/N;
f = f.';



subplot(2, 1, 1);
plot(f, fft_spect)
disp(fft_spect(50))
xlim([0 1000])


subplot(2, 1, 2);
plot(f, dft_spect)
xlim([0 1000])

%plot_spectrum(N, Fs, signal_spectrum)


%subplot(2,1,2)
%plot(k,unwrap(angle(sig))*180/pi)
%title('Phase')


% Get the axes showing, test some other files and see if vals make sense
% (maybe test external fft) and finally make own DFT, then follow tasks
% https://uk.mathworks.com/matlabcentral/answers/544352-wav-file-dft-without-fft