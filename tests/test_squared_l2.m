% Function details
n = 16;
func = @squared_l2_norm_func;
func_name = 'squared_l2_norm';
x0 = squared_l2_norm_point(n);
minimizer_func = @fminsearch_nm;
minimizer_func_name = 'fminsearch_nm_restarts';
output_dir = 'out/data/';

run_test(n, func, func_name, x0, minimizer_func, minimizer_func_name, output_dir);
