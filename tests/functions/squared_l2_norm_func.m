function [value] = squared_l2_norm_func(V)
% -- [value] = squared_l2_norm_func(V)
%
%     Implementation of squared Euclidean norm as described in [1].
%
%   References:
%     [1] J. More, B. Garbow, K. Hillstrom, Testing unconstrained optimization
%         software, ACM Transactions on Mathematical Software 7:1, 17-41.

    % Force vector
    V = V(:);
    value = sum(V .^ 2);
end
