function [x, fval, exitflag, output] = fminsearch_mds(fun, x0, options)
% -- [x, fval, exitflag, output] = fminsearch_mds(fun, x0, options)
%
%     Find value of `x` which minimizes value of `fun` using
%     Multidirectional Search method. This function is a drop-in replacement
%     for built-in `fminsearch` implementation.
%
%     This implementation follows algorithm statement from [1], Section 8.2.
%
%     Minimization parameters are passed through "options" argument. To set
%     this argument, use 'optimset'. Currently supported options are:
%     "Display", "InitialSimplex", "MaxFunEvals", "MaxIter", "OutputFcn",
%     "TolFun", "TolX".
%
%     "InitialSimplex" is a custom option. If set, it overrides the default
%     initial simplex vertices with matrix set as option.
%
%     "TolX" stopping criterion is the minimum allowed simplex oriented length
%     (1e-4 by default).
%
%     For description of other options, see documentation for 'optimset'.
%
%     Structure `optimValues` passed to each 'OutputFcn' function call is
%     extended with additional attributes:
%
%         "fun": handle to the minimized function.
%
%         "simplex_vertices": Matrix of current simplex vertices, in columns.
%
%   References:
%     [1] C. T. Kelley, Iterative Methods for Optimization, Society for
%         Industrial and Applied Mathematics, Philadelphia, PA, 1999.

    % Load helper functions
    if !exist('EXTRA_OPTIM_LOADED', 'var')
        source('includes.m');
    end

    % Use a vector in computations
    x0 = x0(:);

    % Set options
    verbosity              = parse_display_option(options);
    custom_initial_simplex = suppress_warnings(@() optimget(options, 'InitialSimplex', []));  % custom initial simplex override
    kmax                   = optimget(options, 'MaxFunEvals', 200 * length(x0));  % maximum function evaluations
    max_iters              = optimget(options, 'MaxIter', 200 * length(x0));  % maximum iterations
    output_fun             = optimget(options, 'OutputFcn');
    tau                    = optimget(options, 'TolFun', 1e-4);  % maximum function value tolerance
    max_sigma_plus         = optimget(options, 'TolX', 1e-4);  % maximum simplex oriented length

    % Initialize optim_values
    optim_values.fun = fun;

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
    if !isempty(output_fun)
        optim_values.funccount = fcount;
        optim_values.fval = f(1);
        optim_values.iteration = 0;
        optim_values.procedure = 'init';
        optim_values.simplex_vertices = X;
        state = 'init';
        x_1 = X(:, 1);
        if (output_fun(x_1, optim_values, state))
            exitflag = -1;
            output_msg = "Stopped by OutputFcn\n";
        endif
    endif

    iter = 0;
    exitflag = 0;
    output_msg = '';

    % Display log
    if verbosity >= 3
        iter_display_header();
        iter_display_row(iter, fcount, f(1), 'initial simplex');
    end

    % Main loop
    while exitflag != -1

        sigma_plus = simplex_max_oriented_length(X);
        if (f(N+1) - f(1) < tau && sigma_plus < max_sigma_plus)
            exitflag = 1;
            output_msg = sprintf("Sequence converged (f_N+1 - f_1 = %f, sigma_plus = %f). \n", f(N+1) - f(1), sigma_plus);
            break;
        end

        iter++;
        if iter > max_iters
            exitflag = 0;
            break;
        end

        action = '';

        % Terminate if cannot do as many computations
        if fcount >= kmax - N
            exitflag = 0;
            output_msg = "Maximum number of iterations exceeded.\n";
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

        % Display log
        if verbosity >= 3
            iter_display_row(iter, fcount, f(1), action);
        end

        % Call output function
        if !isempty(output_fun)
            optim_values.funccount = fcount;
            optim_values.fval = f(1);
            optim_values.iteration = 0;
            optim_values.procedure = action;
            optim_values.simplex_vertices = X;
            state = 'iter';
            x_1 = X(:, 1);
            if (output_fun(x_1, optim_values, state))
                exitflag = -1;
                break;
            endif
        endif

    end

    % Print final message if verbosity set
    if verbosity > 1 || (verbosity == 1 && exitflag != 1)
        printf("\n");
        printf(output_msg);
    end

    % Set return values
    x = X(:, 1);
    fval = f(1);

    % Call output function
    if !isempty(output_fun)
        optim_values.funccount = fcount;
        optim_values.fval = f(1);
        optim_values.iteration = 0;
        optim_values.procedure = 'finish';
        optim_values.simplex_vertices = X;
        state = 'done';
        x_1 = X(:, 1);
        output_fun(x_1, optim_values, state);
    endif

    % Set output
    output = struct;
    output.iterations = iter;
    output.funcCount = fcount;
    output.algorithm = "Multidirectional Search method";
    output.message = output_msg;

end
