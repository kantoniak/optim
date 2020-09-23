function [exitflag, output_msg] = call_output_fun(output_fun, fun, state, iter, action, X, f, fcount, exitflag, output_msg)
% -- [exitflag, output_msg] = call_output_fun(output_fun, fun, state, iter, action, X, f, fcount, exitflag, output_msg)
%
%     Calls output funtion for fminsearch iterations. May overwrite return values.

    if ~isempty(output_fun)
        optim_values.fun = fun;
        optim_values.funccount = fcount;
        optim_values.fval = f(1);
        optim_values.iteration = iter;
        optim_values.procedure = action;
        optim_values.simplex_vertices = X;
        x_1 = X(:, 1);
        if (output_fun(x_1, optim_values, state))
            exitflag = -1;
            output_msg = 'Stopped by OutputFcn\n';
        end
    end
end
