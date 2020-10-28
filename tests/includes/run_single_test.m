function run_single_test(n, objective, x0, optimizer, output_dir)
% -- run_single_test(n, objective, x0, optimizer, output_dir)
%
%     Run selected minimization test and save iteration history to a file.

    % History setup
    iters = iter_history();
    history_saver = @(x, optimValues, state) save_history(x, optimValues, state, iters);

    % Iteration defaults
    max_evals = 200 * n;
    max_iters = 200 * n;
    tol_x = 1e-4;
    tol_fun = 1e-4;
    initial_simplex_strategy = 1;  % Regular simplex
    halting_test = 4;              % Woods test
    max_restarts = 5;              % Max restarts when restarts enabled
    weak_expansion = true;         % Using f_e < f_r for expansion

    % Set iteration options
    if strcmp(optimizer.func_name, 'fminsearch') || strcmp(optimizer.func_name, 'mdsmin')
        options = optimset(                                                 ...
            'Display', 'notify',                                            ...
            'MaxFunEvals', max_evals,                                       ...
            'MaxIter', max_iters,                                           ...
            'OutputFcn', history_saver,                                     ...
            'TolFun', tol_x,                                                ...
            'TolX', tol_fun                                                 ...
        );
    elseif strcmp(optimizer.func_name, 'fminsearch_nm') || strcmp(optimizer.func_name, 'fminsearch_mds')
        options = xoptimset(                                                ...
            'AcceptWeakExpansion', weak_expansion,                          ...
            'Display', 'notify',                                            ...
            'HaltingTest', halting_test,                                    ...
            'InitialSimplexStrategy', initial_simplex_strategy,             ...
            'MaxFunEvals', max_evals,                                       ...
            'MaxIter', max_iters,                                           ...
            'OutputFcn', history_saver,                                     ...
            'TolFun', tol_x,                                                ...
            'TolX', tol_fun                                                 ...
        );
    elseif strcmp(optimizer.func_name, 'fminsearch_nm_restarts')
        options = xoptimset(                                                ...
            'AcceptWeakExpansion', weak_expansion,                          ...
            'Display', 'notify',                                            ...
            'HaltingTest', halting_test,                                    ...
            'InitialSimplexStrategy', initial_simplex_strategy,             ...
            'MaxFunEvals', max_evals,                                       ...
            'MaxIter', max_iters,                                           ...
            'MaxOrientedRestarts', max_restarts,                            ...
            'OutputFcn', history_saver,                                     ...
            'TolFun', tol_x,                                                ...
            'TolX', tol_fun                                                 ...
        );
    else
        error('xoptim:unknownOptimizer', 'Error.\nUnknown optimizer %s', optimizer.func_name);
    end

    % Run optimizer
    optimizer.func(objective.func, x0, options);
    iters = iters.data;

    % Save iterations
    mkdir(output_dir);
    output_filename = get_output_filename(output_dir, optimizer.func_name, objective.func_name, n);
    save(output_filename, 'iters');

end
