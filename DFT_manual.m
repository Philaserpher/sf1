function[spectrum] = DFT_manual(signal, N)
    disp(N)
    L = size(signal,1);
    signal = signal(:,1);
    %initialise zero vector
    spectrum = zeros(L, 1);
    
    
    for p = 1:N
        % initially DFT(p) = 0
        spectrum(p) = 0;
        disp(p)
        for n = 1:L
            % WHY does ML use 1 indexing, just awful decission
            spectrum(p) = spectrum(p) + signal(n)*exp(-1*1i*2*pi*(n-1)*(p-1)*(1/L));
            
        end
    end



end