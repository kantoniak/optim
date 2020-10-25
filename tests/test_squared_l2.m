% Function details
func = @squared_l2_norm_func;
func_name = 'squared_l2_norm';
x0_func = @squared_l2_norm_point;
dimensions = [1 4 16];
output_dir = 'out/data/';
tests = get_default_test_config();

test_function(func, func_name, x0_func, dimensions, output_dir, tests);
