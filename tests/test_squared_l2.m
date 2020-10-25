% Function details
tests.func = @squared_l2_norm_func;
tests.func_name = 'squared_l2_norm';
tests.x0_func = @squared_l2_norm_point;
tests.dimensions = [1 4 16];
tests.output_dir = 'out/data/';
tests.config = get_default_test_config();

test_function(tests);
