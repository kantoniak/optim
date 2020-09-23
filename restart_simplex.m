function [X, X_prev, f, f_prev] = restart_simplex(N, X, f, sgrad, fun)
% -- [X, X_prev, f, f_prev] = restart_simplex(N, X, f, sgrad, fun)
%
%     Apply oriented restart to input simplex, as described in [1].
%
%   References:
%     [1] C. T. Kelley, Detection and remediation of stagnation in the
%         Nelder-Mead algorithm using a sufficient decrease condition., Society
%         for Industrial and Applied Mathematics, Philadelphia, PA, 1999.

    X_prev = X;
    f_prev = f;

    % Compute new simplex
    V = X(:,2:end) .- X(:,1);
    sigma_min = min(vecnorm(V, 2));
    signum = sign(sgrad);
    signum(signum == 0) = 1; % set plus sign for zero partials
    X = X(:, 1) * ones(1, N+1) - 0.5 * sigma_min * [zeros(N, 1) diag(signum)];

    % Compute values and sort
    for i = 2:N+1
        f(i) = fun(X(:, i));
    end
    [X, X_prev, f, f_prev] = sort_by_values(X, X_prev, f, f_prev);
end
