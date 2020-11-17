function [x0] = fletcher_powell_point(n)
% -- [x0] = fletcher_powell_point(n)
%
%     Implementation of Fletcher-Powell helical valley starting point from [1].
%
%   References:
%     [1] J. More, B. Garbow, K. Hillstrom, Testing unconstrained optimization
%         software, ACM Transactions on Mathematical Software 7:1, 17-41.

    x0 = [-1, 0, 0];
end
