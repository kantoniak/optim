test_case.func = @penalty_1_func;
test_case.func_name = 'penalty_1';
test_case.x0_func = @penalty_1_point;
test_case.dimensions = [16];
test_case.output_dir = 'out/data/';
test_case.optimizers = get_default_optimizers();

max_entry_count = get_max_entry_count(test_case);

plot_options = struct();
plot_options.title = sprintf('Penalty I function - best value by iteration ($ n = %d $)', test_case.dimensions(1));
plot_options.x_range = [0 max_entry_count];

plot_test_case_history_field(test_case, 'fval', plot_options);
