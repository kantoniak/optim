tests.func = @squared_l2_norm_func;
tests.func_name = 'squared_l2_norm';
tests.x0_func = @squared_l2_norm_point;
tests.dimensions = [16];
tests.output_dir = 'out/data/';
tests.config = get_default_test_config();

max_entry_count = get_max_entry_count(tests);

plot_options = struct();
plot_options.title = sprintf('Squared l2 norm - best value by iteration ($ n = %d $)', tests.dimensions(1));
plot_options.x_range = [0 max_entry_count];

plot_tests_history_field(tests, 'fval', plot_options);
