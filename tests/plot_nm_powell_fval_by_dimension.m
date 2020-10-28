test_case.func = @powell_func;
test_case.func_name = 'powell';
test_case.x0_func = @powell_point;
test_case.dimensions = [4 8 12 16 20 24 28 32];
test_case.output_dir = 'out/data/';
test_case.optimizers(1).func = @fminsearch_nm;
test_case.optimizers(1).func_name = 'fminsearch_nm';
test_case.optimizers(1).display_name = 'fminsearch\_nm';
test_case.optimizers(1).line_style = '-';
test_case.optimizers(1).line_width = 0.5;

max_entry_count = get_max_entry_count(test_case);

plot_options = struct();
plot_options.title = sprintf('Powell function optimized with Nelder-Mead by dimension');
plot_options.x_range = [0 max_entry_count];
plot_options.show_legend = true;

plot_test_case_history_field(test_case, 'fval', plot_options);
