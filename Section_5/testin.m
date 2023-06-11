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

% Plot the sine wave
plot(t, sinWave);
xlabel('Time');
ylabel('Amplitude');
title('Sine Wave with 100 Consecutive Samples Set to Zero');
