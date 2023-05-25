function[spectrum] = fft_plot(signal, N)

    fft_spect = fft(signal, N);
    P2 = abs(fft_spect/N);
    spectrum = P2(1:N/2);
    spectrum(2:end-1) = 2*spectrum(2:end-1);


end