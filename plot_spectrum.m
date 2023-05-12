

function[] = plot_spectrum(N, Fs, signal_spectrum)
    k = (2*(0:N-1)/N - 1)*Fs;
    subplot(1,1,1)
    plot(k,abs(signal_spectrum))
    title('Magnitude')
end