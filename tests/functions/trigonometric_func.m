% Trigonometric function implementation.
function [value] = trigonometric_func(V)
    % Force vector
    V = V(:);
    n = size(V, 1);

    % Precompute values
    c = cos(V);
    c_sum = sum(c);
    s = sin(V);
    ic = (c .* 1:n)(:);

    % Compute value
    U = (ic - s .+ 1 .- (1:n)(:)) * n .- c_sum;
    value = sum(U .^ 2);
end
