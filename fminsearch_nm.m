function [x, fval, exitflag, output] = fminsearch_nm(fun, x0, options)
% -- [x, fval, exitflag, output] = fminsearch_nm(fun, x0, options)
%
%     Find value of `x` which minimizes value of `fun` using the Nelder-Mead
%     method. This function is a drop-in replacement for built-in `fminsearch`
%     implementation.
%
%     This implementation follows algorithm statement from [1], Section 8.1.
%
%     Minimization parameters are passed through "options" argument. You can
%     use `optimset` to set these options. If you want to use additional
%     options, use `xoptimset`. Additional options are described in `xoptimset`
%     manpage: `help xoptimset`.
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

    % Use a vector in computations
    x0 = x0(:);

    % Set options
    verbosity                = parse_display_option(options);
    initial_simplex_strategy = xoptimget(options, 'InitialSimplexStrategy', 0);  % initial simplex strategy
    custom_initial_simplex   = xoptimget(options, 'InitialSimplex', []);  % custom initial simplex override
    kmax                     = xoptimget(options, 'MaxFunEvals', 200 * length(x0));  % maximum function evaluations
    max_iters                = xoptimget(options, 'MaxIter', 200 * length(x0));  % maximum iterations
    output_fun               = xoptimget(options, 'OutputFcn', []);
    tol_fun                  = xoptimget(options, 'TolFun', 1e-4);  % maximum function value tolerance
    tol_x                    = xoptimget(options, 'TolX', 1e-4);  % maximum simplex oriented length
    halting_criterion        = xoptimget(options, 'HaltingTest', 0);  % halting test number
    max_restarts             = xoptimget(options, 'MaxOrientedRestarts', 0);  % enable oriented restarts
    greedy_expansion         = xoptimget(options, 'AcceptGreedyExpansion', false);  % enable greedy expansion

    % Prepare output function
    output = @(iter, action, X, f, fcount, exitflag, output_msg) call_output_fun(output_fun, fun, 'iter', iter, action, X, f, fcount, exitflag, output_msg);

    % Set transformation coefficients
    mu_ic = -0.5;    % inside contraction
    mu_oc =  0.5;    % outside contraction
    mu_r  =  1.0;    % reflection
    mu_e  =  2.0;    % expansion

    % Define variables to establish naming
    N = length(x0);
    X = [];          % matrix of vertices
    X_prev = [];     % matrix of vertices in previous iteration
    f = [];          % vector of values in vertices
    f_prev = [];     % vector of values in previous iteration
    fcount = 0;      % number of function evaluations
    iter = 0;        % number of iteration

    % Define initial simplex
    if ~isempty(custom_initial_simplex)
        X = custom_initial_simplex;
    else
        X = create_simplex(initial_simplex_strategy, x0);
    end
    X_prev = X;

    % Compute function values and sort vertices of S
    for i = 1:N+1
        x_i = X(:, i);
        f(i) = fun(x_i);
    end
    f_prev = f;
    fcount = N+1;
    [X, X_prev, f, f_prev] = sort_by_values(X, X_prev, f, f_prev);

    % Initialize oriented restart
    restarts_enabled = (max_restarts > 0);
    if restarts_enabled
        alpha_0 = 0.0001;  % oriented restart parameter
        rcount = 0;  % number of executed oriented restarts

        V = X(:,2:end) - X(:,1);
        sigma_max = max(vecnorm(V, 2));
        sgrad = simplex_gradient(X, f);
        alpha = alpha_0 * sigma_max / norm(sgrad);
    end

    % Call output function
    iter = 0;
    [exitflag, output_msg] = call_output_fun(output_fun, fun, 'init', iter, 'init', X, f, fcount, 0, '');

    % Display log
    if verbosity >= 3
        iter_display_header();
        iter_display_row(iter, fcount, f(1), 'initial simplex');
    end

    % Main loop
    while exitflag ~= -1

        % Skip halting test if using simplex movement and before first iteration
        if (iter == 0 && halting_criterion == 3)
            halt_now = false;
        else
            [halt_now, message] = should_halt(halting_criterion, N, X, X_prev, f, tol_x, tol_fun);
        end

        if halt_now
            exitflag = 1;
            output_msg = message;
            break;
        end

        iter = iter + 1;
        if iter > max_iters
            exitflag = 0;
            output_msg = 'Maximum number of iterations exceeded.\n';
            break;
        end

        X_prev = X;
        f_prev = f;
        action = '';
        shrink = false;

        % (a) Compute centroid and reflection
        x_bar = sum(X(:, 1:N), 2) ./ N;
        x_N1 = X(:,N+1);
        x_r = reflect_about(x_N1, x_bar, mu_r);
        f_r = fun(x_r);

        % Terminate on kmax evaluations
        fcount = fcount + 1;
        if fcount > kmax
            exitflag = 0;
            output_msg = 'Maximum number of function evaluations exceeded.\n';
            break;
        end

        if f_r < f(N)

            % (b) Reflect and sort
            if f(1) <= f_r
                X(:, N+1) = x_r;
                f(N+1) = f_r;

                action = 'reflect';

            % (c) Expand and sort
            else % f_r < f(1)
                x_e = reflect_about(x_N1, x_bar, mu_e);
                f_e = fun(x_e);

                % Terminate on kmax evaluations
                fcount = fcount + 1;
                if fcount > kmax
                    exitflag = 0;
                    output_msg = 'Maximum number of function evaluations exceeded.\n';
                    break;
                end

                if greedy_expansion
                    expand = (f_e < f(1));
                else
                    expand = (f_e < f_r);
                end

                if expand
                    X(:, N+1) = x_e;
                    f(N+1) = f_e;
                    action = 'expand';
                else
                    X(:, N+1) = x_r;
                    f(N+1) = f_r;
                    action = 'reflect';
                end

            end

        else % f(N) <= f_r

            % (d) Outside contract
            if f_r < f(N+1)

                x_oc = reflect_about(x_N1, x_bar, mu_oc);
                f_oc = fun(x_oc);

                % Terminate on kmax evaluations
                fcount = fcount + 1;
                if fcount > kmax
                    exitflag = 0;
                    output_msg = 'Maximum number of function evaluations exceeded.\n';
                    break;
                end

                if f_oc <= f_r
                    X(:, N+1) = x_oc;
                    f(N+1) = f_oc;
                    action = 'outside contract';
                else
                    shrink = true;
                end

            % (e) Inside contract
            else % f(N+1) <= f_r

                x_ic = reflect_about(x_N1, x_bar, mu_ic);
                f_ic = fun(x_ic);

                % Terminate on kmax evaluations
                fcount = fcount + 1;
                if fcount > kmax
                    exitflag = 0;
                    output_msg = 'Maximum number of function evaluations exceeded.\n';
                    break;
                end

                if f_ic < f(N+1)
                    X(:, N+1) = x_ic;
                    f(N+1) = f_ic;
                    action = 'inside contract';
                else
                    shrink = true;
                end

            end

        end

        % (f) Shrink
        if shrink

            % Terminate if cannot do as many evaluations
            if fcount > kmax - N
                exitflag = 0;
                output_msg = 'Maximum number of function evaluations exceeded.\n';
                break;
            end

            x_1 = X(:, 1);
            for i = 2:N+1
                X(:, i) = x_1 - (X(:, i) - x_1) * 0.5;
                f(i) = fun(X(:, i));
            end
            fcount = fcount + N;

            action = 'shrink';

        end

        % (g) Sort vertices of S
        [X, X_prev, f, f_prev] = sort_by_values(X, X_prev, f, f_prev);

        % Display log
        if verbosity >= 3
            iter_display_row(iter, fcount, f(1), action);
        end

        % Call output function
        [exitflag, output_msg] = output(iter, action, X, f, fcount, exitflag, output_msg);
        if exitflag == -1
            break;
        end

        % Oriented restart
        simplex_found = (shrink == false);
        if (simplex_found && restarts_enabled)
            % New simplex was found before shrinking, so average over vertices
            % dropped. We only need to test for sufficient decrease.
            f_avg_diff = (sum(f) - sum(f_prev)) / (N+1);
            X_prev_grad = simplex_gradient(X_prev, f_prev);
            sufficient_decrease = (f_avg_diff < -alpha * norm(X_prev_grad)^2);

            % Jump to next iteration if everything is OK
            if sufficient_decrease == true
                continue; % in main loop
            end

            % Terminate on max_restarts
            rcount = rcount + 1;
            if rcount > max_restarts
                exitflag = 0;
                output_msg = 'Maximum number of oriented restarts exceeded.\n';
                break;
            end

            % Terminate if cannot do as many evaluations
            if fcount > kmax - N
                exitflag = 0;
                output_msg = 'Maximum number of function evaluations exceeded.\n';
                break;
            end
            fcount = fcount + N;

            % Execute restart
            [X, X_prev, f, f_prev] = restart_simplex(N, X_prev, f_prev, X_prev_grad, fun);
            action = 'restart';

            % Display log
            if verbosity >= 3
                iter_display_row(iter, fcount, f(1), action);
            end

            % Call output function
            [exitflag, output_msg] = output(iter, action, X, f, fcount, exitflag, output_msg);
            if exitflag == -1
                break;
            end
        end

    end % end of the main loop

    % Print final message if verbosity set
    if verbosity > 1 || (verbosity == 1 && exitflag ~= 1)
        fprintf('\n');
        fprintf(output_msg);
    end

    % Set return values
    x = X(:, 1);
    fval = f(1);

    % Call output function
    [exitflag, output_msg] = call_output_fun(output_fun, fun, 'done', iter, 'finish', X, f, fcount, exitflag, output_msg);

    % Set output
    output = struct;
    output.iterations = iter;
    output.funcCount = fcount;
    output.algorithm = 'Nelder-Mead method';
    output.message = output_msg;
end
