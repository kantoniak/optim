function run_test(n, func, func_name, x0, minimizer_func, minimizer_func_name, output_dir)
% -- run_test(n, func, func_name, x0, minimizer_func, minimizer_func_name, output_dir)
%
%     Run selecter minimization test and save iteration history to a file.

    % History setup
    iters = iter_history();
    history_saver = @(x, optimValues, state) save_history(x, optimValues, state, iters);

    % Iteration defaults
    max_evals = 200 * n;
    max_iters = 200 * n;
    tol_x = 1e-4;
    tol_fun = 1e-4;

    % Set iteration options
    if strcmp(minimizer_func_name, 'fminsearch')
        options = optimset(                                                 ...
            'Display', 'notify',                                            ...
            'MaxFunEvals', max_evals,                                       ...
            'MaxIter', max_iters,                                           ...
            'OutputFcn', history_saver,                                     ...
            'TolFun', tol_x,                                                ...
            'TolX', tol_fun                                                 ...
        );
    end

    % Run minimizer
    minimizer_func(func, x0, options);
    iters = iters.data;

    % Save iterations
    mkdir(output_dir);
    output_filename = sprintf('%s%s-%s-%d.mat', output_dir, minimizer_func_name, func_name, n);
    save(output_filename, 'iters');

end
