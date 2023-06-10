function x = generate_linear(N, P, theta)
    % Generate G matrix
    G = zeros(N, P);
    for n = 1:N
        G(n, :) = [1, n];
    end

    % Generate error vector (random normal distribution for this example)
    e = randn(N, 1);

    % Compute x
    x = G * theta + e;
end
