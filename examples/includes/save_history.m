function [stop] = save_history(x, optimValues, state, iters)
% -- [stop] = save_history(x, optimValues, state, iters)
%
%     Saves history entries to iteration history `iters`.

    % Compute function values
    X = optimValues.simplex_vertices;
    N = size(X, 1);
    for i = 1:N+1
        f(i) = optimValues.fun(X(:, i));
    end

    % Compute simplex size
    V = X(:, 2:end) - X(:, 1);
    sigma_plus = max(vecnorm(V, 2));

    % Compute gradient
    sgrad = simplex_gradient(X, f);
    sgrad_norm = norm(sgrad);

    % Save new entry
    idx = size(iters.data, 2) + 1;

    iters.data(idx).state = state;
    iters.data(idx).iter = optimValues.iteration;
    iters.data(idx).action = optimValues.procedure;
    iters.data(idx).fcount = optimValues.funccount;
    iters.data(idx).X = optimValues.simplex_vertices;
    iters.data(idx).fval = optimValues.fval;
    iters.data(idx).f = f;
    iters.data(idx).f_diff = f(N+1) - f(1);
    iters.data(idx).sgrad = sgrad;
    iters.data(idx).sgrad_norm = sgrad_norm;
    iters.data(idx).sigma_plus = sigma_plus;

    stop = false;
end
