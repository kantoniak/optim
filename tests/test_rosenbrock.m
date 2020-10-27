% Function details
test_case.func = @(x) rosenbrock_func(x, 1, 100);
test_case.func_name = 'rosenbrock';
test_case.x0_func = @rosenbrock_point;
test_case.dimensions = [4 16];
test_case.output_dir = 'out/data/';
test_case.optimizers = get_default_optimizers();

test_function(test_case);
