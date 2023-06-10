%read = "Sounds/500hz-107658.wav";
%read = "Sounds/organ.wav";
read = "Sounds/f1lcapae.wav";
[signal,Fs] = audioread(read);
T = 1/Fs;             
L = size(signal,1);     


Y = fft(signal);

P2 = abs(Y/L);
P1 = P2(1:floor(L/2)+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,P1)