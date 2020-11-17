function [x0] = powell_point(n)
% -- [x0] = powell_point(n)
%
%     Implementation of extended Powell function starting point from [1].
%
%   References:
%     [1] J. More, B. Garbow, K. Hillstrom, Testing unconstrained optimization
%         software, ACM Transactions on Mathematical Software 7:1, 17-41.

    % Enforce divisibility by 4
    if mod(n, 4) ~= 0
        error('xoptim:incorrectDimension', 'Error.\nInput vector dimension %d not divisible by 4.', n);
    end

    % Compute value
    x0 = [];
    for i = 1:(n/4)
        x0(4*(i-1)+1) = 3;
        x0(4*(i-1)+2) = -1;
        x0(4*(i-1)+3) = 0;
        x0(4*(i-1)+4) = 1;
    end

end
