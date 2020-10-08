% Squared Euclidean norm function.
function [value] = squared_l2_norm_func(V)
    % Force vector
    V = V(:);
    value = sum(V .^ 2);
end
