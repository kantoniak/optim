function test_function(func, func_name, x0_func, dimensions, output_dir, tests)
% -- test_function(func, func_name, x0_func, dimensions, output_dir, tests)
%
%     Run multiple minimization tests and save iteration history to files. If
%     test configurations are empty, all minimizers will run.

    % Use default minimizers if config not set
    if isempty(tests)
        tests = get_default_test_config();
    end

    % Run tests
    for i=1:size(dimensions(:), 1)
        n = dimensions(i);
        for j=1:size(tests.config, 2)
            config = tests.config(j);
            run_test(n, func, func_name, x0_func(n), config.minimizer_func, config.minimizer_func_name, output_dir);
        end
    end

end
