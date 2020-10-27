% Function details
test_case.func = @squared_l2_norm_func;
test_case.func_name = 'squared_l2_norm';
test_case.x0_func = @squared_l2_norm_point;
test_case.dimensions = [1 4 16];
test_case.output_dir = 'out/data/';
test_case.optimizers = get_default_optimizers();

test_function(test_case);
