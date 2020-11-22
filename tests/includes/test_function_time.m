function test_function_time(test_case, repeats)
% -- test_function_time(test_case, repeats)
%
%     Run multiple minimization test_cases and save execution time to files. If
%     test configurations are empty, all optimizers will run.

    % Use default optimizers if config not set
    if field_empty(test_case, 'optimizers')
        test_case.optimizers = get_default_optimizers();
    end

    % Run tests
    for i=1:size(test_case.dimensions(:), 1)
        n = test_case.dimensions(i);
        for j=1:size(test_case.optimizers, 2)
            optimizer = test_case.optimizers(j);

            % Pre-test function
            if ~field_empty(test_case.objective, 'pre_test_func')
                test_case.objective.pre_test_func();
            end

            run_single_time_test(n, test_case.objective, test_case.objective.x0_func(n), optimizer, repeats, test_case.output_dir);
        end
    end

end
