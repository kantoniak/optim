function [value] = penalty_1_func(V)
% -- [value] = penalty_1_func(V)
%
%     Implementation of Penalty I function from [1].
%
%   References:
%     [1] J. More, B. Garbow, K. Hillstrom, Testing unconstrained optimization
%         software, ACM Transactions on Mathematical Software 7:1, 17-41.

    % Force vector
    V = V(:);
    n = size(V, 1);

    U = 10^-5 * (V .- 1).^2;
    U(n+1) = sum(V .^ 2) - 0.25;
    U(n+1) = U(n+1)^2;
    value = sum(U);
end
