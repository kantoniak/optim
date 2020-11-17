function [value] = fletcher_powell_func(V)
% -- [value] = fletcher_powell_func(V)
%
%     Implementation of Fletcher-Powell helical valley function from [1].
%
%   References:
%     [1] J. More, B. Garbow, K. Hillstrom, Testing unconstrained optimization
%         software, ACM Transactions on Mathematical Software 7:1, 17-41.

    % Force vector
    V = V(:);
    n = size(V, 1); % n = 3

    % Precompute values
    theta = atan(V(2)/V(1)) / (2*pi);
    if V(1) < 0
        theta = theta + 0.5;
    end

    % Compute value
    U(1) = 10*V(3) - 100*theta;
    U(2) = 10*(norm(V(1:2)) - 1);
    U(3) = V(3);
    value = sum(U .^ 2);
end
