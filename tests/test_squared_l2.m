% Function details

tests.output_dir = 'out/data/';
tests.dimensions = [16];
tests.func = @squared_l2_norm_func;
tests.func_name = 'squared_l2_norm';
tests.x0 = squared_l2_norm_point(tests.dimensions(1));

idx = 1;
tests.config(idx).minimizer_func = @fminsearch_nm;
tests.config(idx).minimizer_func_name = 'fminsearch_nm_restarts';

run_test(tests.dimensions(1), tests.func, tests.func_name, tests.x0, tests.config(idx).minimizer_func, tests.config(idx).minimizer_func_name, tests.output_dir);
iters = load_test_data(get_output_filename(tests.output_dir, tests.config(idx).minimizer_func_name, tests.func_name, tests.dimensions(1)));
