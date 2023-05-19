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