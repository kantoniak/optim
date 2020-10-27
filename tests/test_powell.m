% Function details
test_case.func = @powell_func;
test_case.func_name = 'powell';
test_case.x0_func = @powell_point;
test_case.dimensions = [4 16];
test_case.output_dir = 'out/data/';
test_case.optimizers = get_default_optimizers();

test_function(test_case);
