test_case.objective = get_objective_func('powell');
test_case.dimensions = [4 8 12 16 20 24 28 32];
test_case.output_dir = 'out/data/';
test_case.optimizers(1).func = @fminsearch_nm;
test_case.optimizers(1).func_name = 'fminsearch_nm';
test_case.optimizers(1).display_name = 'fminsearch\_nm';
test_case.optimizers(1).line_style = '-';
test_case.optimizers(1).line_width = 0.5;

max_entry_count = get_max_entry_count(test_case);

plot_options = struct();
plot_options.title = sprintf('%s optimized with Nelder-Mead by dimension', test_case.objective.display_name);
plot_options.x_range = [0 max_entry_count];
plot_options.show_legend = true;

% Printing
print_options = struct();
print_options.print_path = 'out/nm_powell_fval_by_dimension.tex';
print_options.print_size = [500, 360];

plot_test_case_history_field(test_case, 'fval', plot_options, print_options);
