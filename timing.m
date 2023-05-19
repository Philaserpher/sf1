read = "Sounds/500hz-107658.wav";
%read = "Sounds/organ.wav";
[signal,Fs] = audioread(read);


DATA_POINTS = 50;
MAX_N = 15000;

N = floor(linspace(1, MAX_N, DATA_POINTS));
     
fft_times = zeros(DATA_POINTS, 1);
dft_times = zeros(DATA_POINTS, 1);

for i=1:DATA_POINTS
    disp(i)
    fft_test = @() fft(signal, N(i));
    fft_times(i) = timeit(fft_test);
    dft_test = @() DFT_manual(signal, N(i));
    dft_times(i) = timeit(dft_test);

end


hold on
plot(N, log10(fft_times))
plot(N, log10(dft_times))
legend('FFT', 'DFT');
xlabel('N') 
ylabel('log10(t) (s)')
title('Comparison between FFT and DFT')
hold off