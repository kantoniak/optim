function [value] = rosenbrock_func(V, a, b)
% -- [value] = rosenbrock_func(V, a, b)
%
%     Implementation of extended Rosenbrock function from [1].
%
%   References:
%     [1] J. More, B. Garbow, K. Hillstrom, Testing unconstrained optimization
%         software, ACM Transactions on Mathematical Software 7:1, 17-41.

    % Force vector
    V = V(:);
    n = size(V, 1);

    % Enforce divisibility by 2
    if mod(n, 2) ~= 0
        error('xoptim:incorrectDimension', 'Error.\nInput vector dimension %d not divisible by 2.', n);
    end

    % Compute value
    value = 0;
    for i = 1:(n/2)
        term1 = (V(2*i) - V(2*i-1)^2);
        term2 = a - V(2*i-1);
        value = value + b*(term1^2) + term2^2;
    end

end
