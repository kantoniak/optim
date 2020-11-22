function [value] = variably_dimensioned_func(V)
% -- [value] = variably_dimensioned_func(V)
%
%     Implementation of variably dimensioned function from [1].
%
%   References:
%     [1] J. More, B. Garbow, K. Hillstrom, Testing unconstrained optimization
%         software, ACM Transactions on Mathematical Software 7:1, 17-41.

    % Force vector
    V = V(:);
    n = size(V, 1);

    % Compute value
    U = V - 1;
    U(n+1) = U' * [1:n]';
    U(n+2) = U(n+1).^2;
    value = sum(U .^ 2);
end
