% This is not the complete code, these are the main parts made to be a bit
% more concise to read

% The manually defined DFT function
function[spectrum] = DFT_manual(signal, N)
    signal = signal(:,1);
    %initialise zero vector
    spectrum = zeros(N, 1);
    
    %careful with 1-based indexing
    for p = 1:N
        % initially DFT(p) = 0
        spectrum(p) = 0;
        for n = 1:N
            spectrum(p) = spectrum(p) + signal(n)*exp(-1*1i*2*pi*(n-1)*(p-1)*(1/N));
            
        end
    end

    
end

% Code used to test the time complexity of FFT and DFT
fft_test = @() fft(signal, N(i));
fft_times(i) = timeit(fft_test);

% Window functions code, W being window size
rect_win = [rectwin(W)' zeros(1, L-W)];             % Rectangular
bartlett_win = [bartlett(W)' zeros(1, L-W)];        % Triangular
hamming_win = [hamming(W)' zeros(1, L-W)];          % Hamming
chebyshev_win = [chebwin(W)' zeros(1, L-W)];        % Chebyshev

% Example signal used for noisy analysis (noise_factor is s.d.)
sin_signal = sin(2*pi*f*n) + randn(1, L)*noise_factor;

% Code used for AM
% Linear
A = 100;
B = 10;