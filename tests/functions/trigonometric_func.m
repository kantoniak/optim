function [value] = trigonometric_func(V)
% -- [value] = trigonometric_func(V)
%
%     Implementation of trigonometric function from [1].
%
%   References:
%     [1] J. More, B. Garbow, K. Hillstrom, Testing unconstrained optimization
%         software, ACM Transactions on Mathematical Software 7:1, 17-41.

    % Force vector
    V = V(:);
    n = size(V, 1);

    % Precompute values
    c = cos(V);
    c_sum = sum(c);
    s = sin(V);
    ic = (c .* 1:n)(:);

    % Compute value
    U = (ic - s .+ 1 .- (1:n)(:)) * n .- c_sum;
    value = sum(U .^ 2);
end
