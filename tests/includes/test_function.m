function test_function(test_case)
% -- test_function(test_case)
%
%     Run multiple minimization test_case and save iteration history to files. If
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
            run_single_test(n, test_case.func, test_case.func_name, test_case.x0_func(n), optimizer, test_case.output_dir);
        end
    end

end
