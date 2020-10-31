% Function details
test_case.objective = get_objective_func('penalty_1');
test_case.dimensions = [1 4 8 12 16 20 24 28 32];
test_case.output_dir = 'out/data/';
test_case.optimizers = get_default_optimizers();

test_function(test_case);
