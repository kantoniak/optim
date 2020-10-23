% Function details
n = 16;
func = @squared_l2_norm_func;
x0 = squared_l2_norm_point(n);
minimizer_func = @fminsearch;
func_name = 'squared_l2_norm';
minimizer_func_name = 'fminsearch';
output_dir = 'out/data/';

run_test(n, func, func_name, x0, minimizer_func, minimizer_func_name, output_dir);
