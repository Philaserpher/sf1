function [spectrum] = fft_prep_plot(spectrum, N)

    P2 = abs(spectrum/N);
    P1 = P2(1:floor(N/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);
    spectrum = P1;



end