% Starting point for variably dimensioned function.
function [x0] = variably_dimensioned_point(n)
    x0 = [1:n] * -(1/n) + ones(1, n);
end
