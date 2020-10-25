func = @squared_l2_norm_func;
func_name = 'squared_l2_norm';
x0_func = @squared_l2_norm_point;
dimensions = [16];
output_dir = 'out/data/';
tests = get_default_test_config();

max_entry_count = get_max_entry_count(func_name, dimensions, output_dir, tests, entries);

plot_options = struct();
plot_options.title = 'Function values by iteration';
plot_options.x_range = [0 max_entry_count];

plot_tests_history_field(func_name, dimensions, output_dir, tests, entries, 'fval', plot_options);
