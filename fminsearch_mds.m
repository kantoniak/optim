function [x, fval, exitflag, output] = fminsearch_mds(fun, x0, options)
% -- [x, fval, exitflag, output] = fminsearch_mds(fun, x0, options)
%
%     Find value of `x` which minimizes value of `fun` using
%     Multidirectional Search method. This function is a drop-in replacement
%     for built-in `fminsearch` implementation.
%
%     This implementation follows algorithm statement from [1], Section 8.2.
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

    % Prepare output function
    output = @(iter, action, X, f, fcount, exitflag, output_msg) call_output_fun(output_fun, fun, 'iter', iter, action, X, f, fcount, exitflag, output_msg);

    % Set transformation coefficients
    mu_e  =  2.0;    % expansion
    mu_c  =  0.5;    % contraction

    % Define variables to establish naming
    N = length(x0);
    X = [];          % matrix of vertices
    X_prev = [];     % matrix of vertices in previous iteration
    f = [];          % vector of values in vertices
    fcount = 0;      % number of function evaluations
    iter = 0;        % number of iteration

    % Define initial simplex
    if ~isempty(custom_initial_simplex)
        X = custom_initial_simplex;
    else
        X = create_simplex(initial_simplex_strategy, x0);
    end
    X_prev = X;

    % Evaluate `f` at the vertices of S and sort the vertices
    for i = 1:N+1
        x_i = X(:, i);
        f(i) = fun(x_i);
    end
    fcount = N+1;
    [X, X_prev, f, ~] = sort_by_values(X, X_prev, f, []);

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
        action = '';

        % Terminate if cannot do as many evaluations
        if fcount > kmax - N
            exitflag = 0;
            output_msg = 'Maximum number of function evaluations exceeded.\n';
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
        fcount = fcount + N;

        % (b) Expand
        min_fr = min(fr(2:end));
        if f(1) > min_fr

            % Terminate if cannot do as many evaluations
            if fcount > kmax - N
                exitflag = 0;
                output_msg = 'Maximum number of function evaluations exceeded.\n';
                break;
            end

            E(:, 1) = X(:, 1);
            fe(1) = f(1);
            for j=2:N+1
                E(:, j) = (1+mu_e)*x_1 - mu_e*X(:, j);
                fe(j) = fun(E(:, j));
            end
            fcount = fcount + N;

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

            % Terminate if cannot do as many evaluations
            if fcount > kmax - N
                exitflag = 0;
                output_msg = 'Maximum number of function evaluations exceeded.\n';
                break;
            end

            for j=2:N+1
                X(:, j) = (1+mu_c)*x_1 - mu_c*X(:, j);
                f(j) = fun(X(:, j));
            end
            fcount = fcount + N;
            action = 'contract';

        end

        % (d) Sort
        [X, X_prev, f, ~] = sort_by_values(X, X_prev, f, []);

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
    output.algorithm = 'Multidirectional Search method';
    output.message = output_msg;

end
