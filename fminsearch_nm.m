function [x, fval, exitflag, output] = fminsearch_nm(fun, x0, options)
% -- [x, fval, exitflag, output] = fminsearch_nm(fun, x0, options)
%
%     Find value of `x` which minimizes value of `fun` using the Nelder-Mead
%     method. This function is a drop-in replacement for built-in `fminsearch`
%     implementation.
%
%     This implementation follows algorithm statement from [1], Section 8.1.
%
%   References:
%     [1] C. T. Kelley, Iterative Methods for Optimization, Society for
%         Industrial and Applied Mathematics, Philadelphia, PA, 1999.

    % Temporary return values
    exitflag = 0;
    outfcn = optimget(options, "OutputFcn");

    % Use a vector in computations
    x0 = x0(:);

    % Set parameters
    % TODO(kantoniak): Handle fminsearch options
    tau = 0;      % error tolerance
    kmax = 400;       % maximum function evaluations

    % Set transformation coefficients
    mu_ic = -0.5;    % inside contraction
    mu_oc =  0.5;    % outside contraction
    mu_r  =  1.0;    % reflection
    mu_e  =  2.0;    % expansion

    % Define initial simplex
    N = length(x0);
    X(:, 1) = x0;
    for i = 1:N
        X(:, i+1) = x0;
        X(i, i+1) += i;
    end

    % Compute function values and sort vertices of S
    for i = 1:N+1
        x_i = X(:, i);
        f(i) = fun(x_i);
    end
    fcount = N+1;

    % TODO(kantoniak): Call output function

    [X, f] = sort_by_values(X, f);

    iter = 0;
    while f(N+1) - f(1) > tau
        
        iter++;
        action = '';

        % (a) Compute centroid and reflection
        x_bar = sum(X(:, 1:N), 2) ./ N;
        x_N1 = X(:,N+1);
        x_r = reflect_about(x_N1, x_bar, mu_r);
        f_r = fun(x_r);

        % Terminate on kmax computations
        fcount++;
        if fcount == kmax
            exitflag = 0;
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

                % Terminate on kmax computations
                fcount++;
                if fcount == kmax
                    exitflag = 0;
                    break;
                end

                if f_e < f_r
                    X(:, N+1) = x_e;
                    f(N+1) = f_e;
                else
                    X(:, N+1) = x_r;
                    f(N+1) = f_r;
                end

                action = 'expand';
            end

        else % f(N) <= f_r

            shrink = false;

            % (d) Outside contract
            if f_r < f(N+1)
            
                x_oc = reflect_about(x_N1, x_bar, mu_oc);
                f_oc = fun(x_oc);

                % Terminate on kmax computations
                fcount++;
                if fcount == kmax
                    exitflag = 0;
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

                % Terminate on kmax computations
                fcount++;
                if fcount == kmax
                    exitflag = 0;
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

            % (f) Shrink
            if shrink

                % Terminate if cannot do as many computations
                if fcount >= kmax - N
                    exitflag = 0;
                    break;
                end

                x_1 = X(:, 1);
                for i = 2:N+1
                    X(:, i) = x_1 - (X(:, i) - x_1) * 0.5;
                    f(i) = fun(X(:, i));
                end
                fcount += N;

                action = 'shrink';

            end

        end

        % (g) Sort vertices of S
        [X, f] = sort_by_values(X, f);

        % TODO(kantoniak): Call output function

    end

    % TODO(kantoniak): Call output function

    % Set values
    x = X(:, 1);
    fval = f(1);

    % Set output
    output = struct;
    output.iterations = iter;
    output.funcCount = fcount;
    output.algorithm = "Nelder-Mead method";
end

% Reflect `x` about `y` with coefficient `mu`
function [z] = reflect_about(x, y, mu)
    z = (1 + mu)*y - mu*x;
end

% Sort `f` and apply the same permutation to columns of `X`
function [Xs, fs] = sort_by_values(X, f)
    [~, i] = sort(f);    % I holds sorting order
    Xs = X(:,i);         % apply this order to vector
    fs = f(i);
end
