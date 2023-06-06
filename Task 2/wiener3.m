
    % Can't be negative!!!
    clean_power_spectrum = max(clean_power_spectrum, 0); 
    
    % Apply Wiener filter to obtain the estimated clean signal spectrum
    estimated_clean_spectrum = X_w(:, frame_no) .* (clean_power_spectrum ./ (clean_power_spectrum + noise_power_spectrum(:, frame_no)));
    
    % ADD LINE TO MAKE CONJUGATE SYMMETRIC
    estimated_clean_spectrum(N/2+2:N) = conj(estimated_clean_spectrum(N/2:-1:2));
    
    % IFFT the spectrum
    y_w(:, frame_no) = ifft(estimated_clean_spectrum);
end

% Overlap and add to the output signal
for frame_no = 1:N_frames-2
    y_out((frame_no-1)*overlap+1:(frame_no-1)*overlap+N) = ...
        y_out((frame_no-1)*overlap+1:(frame_no-1)*overlap+N) + y_w(:, frame_no)';
end

% Plot the original signal, noisy signal, and processed output
subplot(3, 1, 1);
plot(t, x_in_noiseless);
title('Original Signal');

subplot(3, 1, 2);
plot(t, x_in);
title('Noisy Signal');

subplot(3, 1, 3);
plot(t, real(y_out));
title('Processed Output');



