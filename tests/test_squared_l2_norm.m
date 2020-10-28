% Function details
test_case.objective = get_objective_func('squared_l2_norm');
test_case.dimensions = [1 4 16];
test_case.output_dir = 'out/data/';
test_case.optimizers = get_default_optimizers();

test_function(test_case);
