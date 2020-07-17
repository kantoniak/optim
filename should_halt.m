function [result, output_msg] = should_halt(test_num, N, X, f, tolX, tolFun)
% -- result = should_halt(test_num, X, f)
%
%     Check if simplex method iterations should halt based on stopping test.
%     There are multiple tests identified by `test_num` variable:
%
%       '0': Default Matlab test for function values AND maximum simplex
%            bounding box dimension.
%
%     If `result` is true, then `output_msg` will contain convergence message.

    switch test_num

        % Matlab default
        case 0
            max_sigma_plus = tolX;
            sigma_plus = simplex_max_oriented_length(X);
            if (f(N+1) - f(1) < tolFun && sigma_plus < max_sigma_plus)
                result = true;
                output_msg = sprintf('Sequence converged (f_N+1 - f_1 = %f, sigma_plus = %f). \n', f(N+1) - f(1), sigma_plus);
            else
                result = false;
                output_msg = [];
            end

        otherwise
            error('Unknown halting test number.');
    end

end
