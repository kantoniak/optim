% Set up test_case
test_case.objective = get_objective_func('powell');
test_case.dimensions = [4 8 12 16 20 24 28 32];
test_case.output_dir = 'out/data/';
test_case.optimizers(1).func = @fminsearch_nm;
test_case.optimizers(1).func_name = 'fminsearch_nm';
test_case.optimizers(1).display_name = 'fminsearch\_nm';
test_case.optimizers(1).line_style = '-';
test_case.optimizers(1).line_width = 0.5;
test_case.optimizers(1).scatter = true;
test_case.optimizers(1).polyfit = 5;

field_names = {'sgrad_norm', 'scond', 'sigma_plus', 'sigmaplus_scond'};
plot_dims = [2 2];

plot_options = struct('', {});
plot_options(1).title = 'Simplex gradient norm';
plot_options(2).title = 'Simplex condition';
plot_options(2).show_legend = true;
plot_options(3).title = 'Sigma plus';
plot_options(4).title = 'Sigma plus times condition';

% Printing
print_options = struct();
print_options.print_path = 'out/nm_powell_details_by_dimension.tex';
print_options.print_size = [500, 720];

plot_test_cases_history_fields(test_case, field_names, plot_dims, plot_options, print_options);
