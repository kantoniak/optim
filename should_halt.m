function [result, output_msg] = should_halt(test_num, N, X, f, tolX, tolFun)
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
%     If `result` is true, then `output_msg` will contain convergence message.
%
%   References:
%     [1] Nelder, J. A., & Mead, R. (1965). A simplex method for function
%         minimization. The computer journal, 7(4), 308-313.

    switch test_num

        % Matlab default
        case 0
            max_max_norm_inf = tolX;
            max_norm_inf = simplex_max_norm_inf(X);
            if (f(N+1) - f(1) < tolFun && max_norm_inf < max_max_norm_inf)
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

        otherwise
            error('Unknown halting test number.');
    end

end
