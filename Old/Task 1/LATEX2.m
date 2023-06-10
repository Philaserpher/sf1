% Sinusoidal
beta = 0.5;
f2 = 5;

% Random
random_part = randn(1, L)*0.9;
for i=2:L
    random_part(i) = random_part(i) + random_part(i-1);
end

sin_signal_linear = sin(2*pi*f*n).*(A+B*n);
sin_signal_periodic = sin(2*pi*f*n).*(beta*sin(2*pi*f2*n) + 1);
sin_signal_random = sin(2*pi*f*n).*random_part;

% Tasks 6, 7 and 8 mostly used parts of code used before in different
% combinations
