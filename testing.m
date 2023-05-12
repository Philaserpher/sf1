[signal,Fs] = audioread("f1lcapae.wav");

N = size(signal,1);

signal_spectrum = fft(signal);





plot_spectrum(N, Fs, signal_spectrum)


%subplot(2,1,2)
%plot(k,unwrap(angle(sig))*180/pi)
%title('Phase')


% Get the axes showing, test some other files and see if vals make sense
% (maybe test external fft) and finally make own DFT, then follow tasks
% https://uk.mathworks.com/matlabcentral/answers/544352-wav-file-dft-without-fft