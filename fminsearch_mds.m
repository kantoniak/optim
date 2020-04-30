function [x, fval, exitflag, output] = fminsearch_mds(fun, x0, options)
% -- [x, fval, exitflag, output] = fminsearch_mds(fun, x0, options)
%
%     Find value of `x` which minimizes value of `fun` using
%     Multidirectional Search method. This function is a drop-in replacement
%     for built-in `fminsearch` implementation.
%
%     This implementation follows algorithm statement from [1], Section 8.2.
%
%   References:
%     [1] C. T. Kelley, Iterative Methods for Optimization, Society for
%         Industrial and Applied Mathematics, Philadelphia, PA, 1999.

    % Temporary return values
    exitflag = 0;

    % Use a vector in computations
    x0 = x0(:);

    % Set parameters
    % TODO(kantoniak): Handle fminsearch options
    tau = 0;      % error tolerance
    kmax = 400;       % maximum function evaluations
    output_fun = optimget(options, 'OutputFcn');
    custom_initial_simplex = optimget(options, 'InitialSimplex', []);

    % Set transformation coefficients
    mu_e  =  2.0;    % expansion
    mu_c  =  0.5;    % contraction

    % Define initial simplex
    N = length(x0);
    if (!isempty(custom_initial_simplex))
        X = custom_initial_simplex;
    else
        X(:, 1) = x0;
        for i = 1:N
            X(:, i+1) = x0;
            X(i, i+1) += i;
        end
    end

    % Evaluate `f` at the vertices of S and sort the vertices
    for i = 1:N+1
        x_i = X(:, i);
        f(i) = fun(x_i);
    end
    fcount = N+1;
    [X, f] = sort_by_values(X, f);

    % Call output function
    if (!isempty(output_fun))
        optim_values.funccount = fcount;
        optim_values.fval = f(1);
        optim_values.iteration = 0;
        optim_values.procedure = 'init';
        state = 'init';
        if (output_fun(X, optim_values, state))
            exitflag = -1;
        endif
    endif

    iter = 0;
    while (exitflag != -1 && f(N+1) - f(1) > tau)
        
        iter++;
        action = '';

        % Terminate if cannot do as many computations
        if fcount >= kmax - N
            exitflag = 0;
            break;
        end

        % (a) Reflect
        x_1 = X(:, 1);
        R(:, 1) = X(:, 1);
        fr(1) = f(1);
        for j=2:N+1
            R(:, j) = 2*x_1 - X(:, j);
            fr(j) = fun(R(:, j));
        end
        fcount += N;

        % (b) Expand
        min_fr = min(fr(2:end));
        if f(1) > min_fr
    
            % Terminate if cannot do as many computations
            if fcount >= kmax - N
                exitflag = 0;
                break;
            end

            E(:, 1) = X(:, 1);
            fe(1) = f(1);
            for j=2:N+1
                E(:, j) = (1+mu_e)*x_1 - mu_e*X(:, j);
                fe(j) = fun(E(:, j));
            end
            fcount += N;

            min_fe = min(fe(2:end));
            if min_fr > min_fe
                X = E;
                f = fe;
                action = 'expand';
            else
                X = R;
                f = fr;
                action = 'reflect';
            end

        % (c) Contract
        else % f(1) <= min(fr)

            % Terminate if cannot do as many computations
            if fcount >= kmax - N
                exitflag = 0;
                break;
            end

            for j=2:N+1
                X(:, j) = (1+mu_c)*x_1 - mu_c*X(:, j);
                f(j) = fun(X(:, j));
            end
            fcount += N;
            action = 'contract';

        end

        % (d) Sort
        [X, f] = sort_by_values(X, f);

        % Call output function
        if (!isempty(output_fun))
            optim_values.funccount = fcount;
            optim_values.fval = f(1);
            optim_values.iteration = 0;
            optim_values.procedure = action;
            state = 'iter';
            if (output_fun(X, optim_values, state))
                exitflag = -1;
                break;
            endif
        endif

    end

    % Set values
    x = X(:, 1);
    fval = f(1);
    if f(N+1) - f(1) <= tau
        exitflag = 1;
    end

    % Call output function
    if (!isempty(output_fun))
        optim_values.funccount = fcount;
        optim_values.fval = f(1);
        optim_values.iteration = 0;
        optim_values.procedure = 'finish';
        state = 'done';
        output_fun(X, optim_values, state);
    endif

    % Set output
    output = struct;
    output.iterations = iter;
    output.funcCount = fcount;
    output.algorithm = "Multidirectional Search method";

end

% Sort `f` and apply the same permutation to columns of `X`
function [Xs, fs] = sort_by_values(X, f)
    [~, i] = sort(f);    % I holds sorting order
    Xs = X(:,i);         % apply this order to vector
    fs = f(i);
end

