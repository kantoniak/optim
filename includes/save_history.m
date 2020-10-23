function [stop] = save_history(x, optimValues, state, iters)
% -- [stop] = save_history(x, optimValues, state, iters)
%
%     Saves history entries to iteration history `iters`. For history of
%     built-in fminsearch, some fields can be empty.

    if isfield(optimValues, 'simplex_vertices')

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

    end

    % Save new entry
    idx = size(iters.data, 2) + 1;

    iters.data(idx).state = state;
    iters.data(idx).iter = optimValues.iteration;
    iters.data(idx).action = optimValues.procedure;
    iters.data(idx).fcount = optimValues.funccount;
    iters.data(idx).fval = optimValues.fval;
    iters.data(idx).x = x;

    if isfield(optimValues, 'simplex_vertices')
        iters.data(idx).X = optimValues.simplex_vertices;
        iters.data(idx).f = f;
        iters.data(idx).f_diff = f(N+1) - f(1);
        iters.data(idx).scond = cond(V);
        iters.data(idx).sgrad = sgrad;
        iters.data(idx).sgrad_norm = sgrad_norm;
        iters.data(idx).sigma_plus = sigma_plus;
    end

    stop = false;
end
