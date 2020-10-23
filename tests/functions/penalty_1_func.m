% Penalty function I implementation.
function [value] = penalty_1_func(V)
    % Force vector
    V = V(:);
    n = size(V, 1);
    U = 10^-5 * (V .- 1);
    U(n+1) = sum(V .^ 2) - 0.25;
    U(n+1) = U(n+1)^2;
    value = sum(U);
end
