function test_function(tests)
% -- test_function(tests)
%
%     Run multiple minimization tests and save iteration history to files. If
%     test configurations are empty, all minimizers will run.

    % Use default minimizers if config not set
    if field_empty(tests, 'config')
        tests.config = get_default_test_config();
    end

    % Run tests
    for i=1:size(tests.dimensions(:), 1)
        n = tests.dimensions(i);
        for j=1:size(tests.config, 2)
            config = tests.config(j);
            run_test(n, tests.func, tests.func_name, tests.x0_func(n), config.minimizer_func, config.minimizer_func_name, tests.output_dir);
        end
    end

end
