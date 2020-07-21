function [result, output_msg] = should_halt(test_num, N, X, X_prev, f, tolX, tolFun)
% -- [result, output_msg] = should_halt(test_num, N, X, f, tolX, tolFun)
%
%     Check if simplex method iterations should halt based on stopping test.
%     There are multiple tests identified by `test_num` parameter:
%
%       '0': Default Matlab test for function values AND maximum simplex
%            bounding box dimension.
%
%       '1': "Standard error test" as introduced in Nelder-Mead algorithm
%            statement (see [1]). Uses `tolFun` as epsilon.
%
%       '2': Parkinson-Hutchinson test for difference of function values in the
%            best and the worst vertex. Uses `tolFun` as epsilon.
%
%       '3': Parkinson-Hutchinson test for difference of vertex positions
%            between iterations. Uses `tolX` as epsilon.
%
%       '4': Woods test for relative simplex size. Uses `tolX` as epsilon.
%
%     If `result` is true, then `output_msg` will contain convergence message.
%
%   References:
%     [1] Nelder, J. A., & Mead, R. (1965). A simplex method for function
%         minimization. The computer journal, 7(4), 308-313.

    switch test_num

        % Matlab default
        case 0
            X_diff = X(:,2:end) .- X(:,1);
            max_norm_inf = max(vecnorm(X_diff, Inf));
            if (f(N+1) - f(1) < tolFun && max_norm_inf < tolX)
                result = true;
                output_msg = sprintf('Sequence converged (f_N+1 - f_1 = %f, max_norm_inf = %f).\n', f(N+1) - f(1), max_norm_inf);
            else
                result = false;
                output_msg = [];
            end

        % "Standard error" by Nelder and Mead
        case 1
            f_bar = sum(f) / (N+1);
            se = sqrt(sum((f .- f_bar) .^ 2) / (N+1));
            if se < tolFun
                result = true;
                output_msg = sprintf('Sequence converged (standard error = %f).\n', se);
            else
                result = false;
                output_msg = [];
            end

        % Function values difference by Parkinson and Hutchinson
        case 2
            if (f(N+1) - f(1) < tolFun)
                result = true;
                output_msg = sprintf('Sequence converged (f_N+1 - f_1 = %f).\n', f(N+1) - f(1));
            else
                result = false;
                output_msg = [];
            end

        % Vertex position difference between iterations by Parkinson and
        % Hutchinson
        case 3
            % Uses all vertices (including the best one), because the best one
            % from previous iteration could have been moved to some other
            % position. At least one of the vectors of X_diff should be 0.
            X_diff = abs(X - X_prev);
            X_diff_norm_squared = sum(X_diff .^ 2);
            expr = sum(X_diff_norm_squared) / N;

            if (expr < tolX)
                result = true;
                output_msg = sprintf('Sequence converged (expr = %f).\n', expr);
            else
                result = false;
                output_msg = [];
            end

        % Woods test for relative simplex size
        case 4
            delta = max(1, norm(X(:,1), 2));
            X_diff = X(:,2:end) .- X(:,1);
            expr = max(vecnorm(X_diff, 2)) / delta;

            if (expr < tolX)
                result = true;
                output_msg = sprintf('Sequence converged (expr = %f).\n', expr);
            else
                result = false;
                output_msg = [];
            end

        otherwise
            error('Unknown halting test number.');
    end

end
