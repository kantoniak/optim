% Variably dimensioned function implementation.
function [value] = variably_dimensioned_func(V)
    % Force vector
    V = V(:);
    n = size(V, 1);

    % Compute value
    U = V .- 1;
    U(n+1) = U' * [1:n]';
    U(n+2) = U(n+1).^2;
    value = sum(U .^ 2);
end
