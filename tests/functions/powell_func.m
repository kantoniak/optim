% Extended Powell singular function implementation.
% Based on https://www.sfu.ca/~ssurjano/powell.html
function [value] = powell_func(V)
    % Force vector
    V = V(:);
    n = size(V, 1);

    % Enforce divisibility by 4
    if mod(n, 4) ~= 0
        error('xoptim:incorrectDimension', 'Error.\nInput vector dimension %d not divisible by 4.', n);
    end

    % Compute value
    value = 0;
    for i = 1:(n/4)
        term1 = (V(4*i-3) + 10*V(4*i-2))^2;
        term2 = 5 * (V(4*i-1) - V(4*i))^2;
        term3 = (V(4*i-2) - 2*V(4*i-1))^4;
        term4 = 10 * (V(4*i-3) - V(4*i))^4;
        value = value + term1 + term2 + term3 + term4;
    end

end
