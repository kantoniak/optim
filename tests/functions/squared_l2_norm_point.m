function [x0] = squared_l2_norm_point(n)
% -- [x0] = squared_l2_norm_point(n)
%
%     Implementation of squared Euclidean norm function starting point from
%     [1].
%
%   References:
%     [1] J. More, B. Garbow, K. Hillstrom, Testing unconstrained optimization
%         software, ACM Transactions on Mathematical Software 7:1, 17-41.

    x0 = 10 * ones(1, n);
end
