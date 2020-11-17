function [x0] = variably_dimensioned_point(n)
% -- [value] = variably_dimensioned_func(V)
%
%     Implementation of variably dimensioned function starting point from [1].
%
%   References:
%     [1] J. More, B. Garbow, K. Hillstrom, Testing unconstrained optimization
%         software, ACM Transactions on Mathematical Software 7:1, 17-41.

    x0 = [1:n] * -(1/n) + ones(1, n);
end
