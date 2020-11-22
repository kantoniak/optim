% Plot best function value over iteration separately for each function.
dimensions = [4 8 12 16 20 24 28 32];
output_dir = 'out/data/';

% Optimizers
optimizers = struct('func', {});

optimizers(1).func = @fminsearch_mds;
optimizers(1).func_name = 'fminsearch_nm';
optimizers(1).display_name = 'fminsearch\_nm';
optimizers(1).line_style = '-';
optimizers(1).line_width = 0.5;
optimizers(1).moving_average = 17;

optimizers(2).func = @fminsearch_mds;
optimizers(2).func_name = 'fminsearch_mds';
optimizers(2).display_name = 'fminsearch\_mds';
optimizers(2).line_style = '--';
optimizers(2).line_width = 0.5;
optimizers(2).moving_average = 17;

% Objective function
test_case.objective = get_objective_func('powell');
test_case.optimizers = optimizers;
test_case.output_dir = output_dir;

plot_options = struct();
plot_options.title = 'Simplex size (sigma_plus) over iterations';
plot_options.show_legend = true;

% Run for all dimensions
dimension_count = size(dimensions, 2);
for d=1:dimension_count
    % Update dimensions
    dim = dimensions(d);
    test_case.dimensions = [dim];

    % Printing
    print_options = struct();
    print_options.print_path = sprintf('out/plot_nm_mds_powell_sigmaplus_by_dimension_r%d.tex', dim);
    print_options.print_size = [400, 275];

    max_entry_count = get_max_entry_count(test_case);
    plot_options.x_range = [0 max_entry_count];

    % Plot
    clf();
    plot_test_case_history_field(test_case, 'sigma_plus', plot_options, print_options);

    print_options.print_path = strrep(print_options.print_path, '.tex', '.png');
    print_options.print_size = print_options.print_size .* 2;
    print_plot(print_options);
end
