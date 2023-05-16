read = "Sounds/500hz-107658.wav";
%read = "Sounds/organ.wav";
%read = "Sounds/f1lcapae.wav";

[signal,Fs] = audioread(read);
T = 1/Fs;
L = size(signal,1);
N = 200;

%initialise zero vector
DFT = zeros(L, 1);


for p = 1:N
    % initially DFT(p) = 0
    DFT(p) = 0;
    for n = 1:L
        % WHY does ML use 1 indexing, just awful decission
        DFT(p) = DFT(p) + signal(n)*exp(-1*1i*2*pi*(n-1)*(p-1)*(1/L));
    end
end


P2 = abs(DFT/L);
P1 = P2(1:floor(L/2)+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,P1)
xlim([0 1000])