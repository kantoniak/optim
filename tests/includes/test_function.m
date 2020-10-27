function test_function(test_case)
% -- test_function(test_case)
%
%     Run multiple minimization test_case and save iteration history to files. If
%     test configurations are empty, all minimizers will run.

    % Use default minimizers if config not set
    if field_empty(test_case, 'config')
        test_case.config = get_default_test_config();
    end

    % Run tests
    for i=1:size(test_case.dimensions(:), 1)
        n = test_case.dimensions(i);
        for j=1:size(test_case.config, 2)
            config = test_case.config(j);
            run_single_test(n, test_case.func, test_case.func_name, test_case.x0_func(n), config.minimizer_func, config.minimizer_func_name, test_case.output_dir);
        end
    end

end
