% Number of samples
numSamples = 1000;

% Frequency of the sine wave (in Hz)
frequency = 1; % Adjust this value to change the frequency

% Time vector
t = linspace(0, 1, numSamples);

% Generate the sine wave
sinWave = sin(2*pi*frequency*t);

% Set 100 consecutive samples to zero
startIndex = 501; % Start index of the samples to be set to zero
endIndex = startIndex + 99; % End index of the samples to be set to zero
sinWave(startIndex:endIndex) = 0;
signal = sinWave;

% Positions where signal is missing
missing_pos = find(signal == 0);

% Parameters for AR model
order = 3; % AR model order
a = linspace(1, 0, numel(missing_pos)); % Weighting parameter

% Preallocate array for predicted signal
predicted_signal = zeros(size(signal));

for i = 1:numel(missing_pos)
    % Index of missing packet
    idx = missing_pos(i);
    
    % Backward prediction
    if idx > order
        % Build AR model using previous known data
        data_prev = signal(idx-order:idx-1);
        model_prev = armax(data_prev', order);
        
        % Predict next value based on AR model
        x4_backwards = predict(model_prev, 1);
    else
        x4_backwards = 0;
    end
    
    % Forward prediction
    if idx < numel(signal) - order
        % Build AR model using following known data
        data_next = signal(idx+1:idx+order);
        model_next = armax(data_next', order);
        
        % Predict previous value based on AR model
        x4_forwards = predict(model_next, 1);
    else
        x4_forwards = 0;
    end
    
    % Weighted sum of backward and forward predictions
    predicted_signal(idx) = a(i)*x4_backwards + (1-a(i))*x4_forwards;
end

% Replace missing packets in original signal with predicted values
signal(missing_pos) = predicted_signal(missing_pos);

% Plot the sine wave
hold on;
plot(t, sinWave);
plot(t, signal);
xlabel('Time');
ylabel('Amplitude');
title('Sine Wave with 100 Consecutive Samples Set to Zero');
