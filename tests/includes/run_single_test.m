function run_single_test(n, objective, x0, optimizer, output_dir)
% -- run_single_test(n, objective, x0, optimizer, output_dir)
%
%     Run selected minimization test and save iteration history to a file.

    % History setup
    iters = iter_history();
    history_saver = @(x, optimValues, state) save_history(x, optimValues, state, iters);

    % Iteration defaults
    max_evals = 200 * n * n;
    max_iters = 200 * n;
    tol_x = 1e-4;
    tol_fun = 1e-4;
    initial_simplex_strategy = 1;  % Regular simplex
    halting_test = 4;              % Woods test
    max_restarts = 20;             % Max restarts when restarts enabled
    greedy_expansion = false;      % (Not) using f_e < f_1 for expansion

    % Settings from optimizer
    if ~field_empty(optimizer, 'greedy_expansion')
        greedy_expansion = optimizer.greedy_expansion;
    end

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
            'AcceptGreedyExpansion', greedy_expansion,                      ...
            'Display', 'notify',                                            ...
            'HaltingTest', halting_test,                                    ...
            'InitialSimplexStrategy', initial_simplex_strategy,             ...
            'MaxFunEvals', max_evals,                                       ...
            'MaxIter', max_iters,                                           ...
            'OutputFcn', history_saver,                                     ...
            'TolFun', tol_x,                                                ...
            'TolX', tol_fun                                                 ...
        );
    elseif strcmp(optimizer.func_name, 'fminsearch_nm_greedy')
        options = xoptimset(                                                ...
            'AcceptGreedyExpansion', true,                                  ...
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
            'AcceptGreedyExpansion', greedy_expansion,                      ...
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

    % Show info message
    message = sprintf('> Testing %s, %s, %d...', optimizer.func_name, objective.func_name, n);
    disp(message);

    % Run optimizer
    optimizer.func(objective.func, x0, options);
    iters = iters.data;

    % Save iterations
    mkdir_p(output_dir);
    output_filename = get_output_filename(output_dir, optimizer, objective.func_name, n);
    save(output_filename, 'iters');

end
