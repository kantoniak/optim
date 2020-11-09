% Plot best function value over iteration separately for each function.
dimensions = [4 8 12 16 20 24 28 32];

% Optimizers
optimizers = struct('func', {});

optimizers(1).func = @fminsearch_nm;
optimizers(1).func_name = 'fminsearch_nm';
optimizers(1).display_name = 'fminsearch\_nm';
optimizers(1).line_style = '-';
optimizers(1).line_width = 0.5;

optimizers(2).func = @fminsearch_mds;
optimizers(2).func_name = 'fminsearch_mds';
optimizers(2).display_name = 'fminsearch\_mds';
optimizers(2).line_style = '--';
optimizers(2).line_width = 0.5;

optimizers(3).func = @fminsearch_nm;
optimizers(3).func_name = 'fminsearch_nm_restarts';
optimizers(3).display_name = 'fminsearch\_nm (with restarts)';
optimizers(3).line_style = ':';
optimizers(3).line_width = 0.5;

% Test case
test_case = struct();
test_case.objective = get_objective_func('rosenbrock');
test_case.optimizers = optimizers;
test_case.output_dir = 'out/data/';

plot_options = struct();
plot_options.title = test_case.objective.display_name;
plot_options.show_legend = true;

% Run for all dimensions
dimension_count = size(dimensions, 2);
for d=1:dimension_count
    dim = dimensions(d);

    test_case.dimensions = [dim];
    max_entry_count = get_max_entry_count(test_case);
    plot_options.x_range = [0 max_entry_count];

    % Tick corrections
    if (dim == 0)
        plot_options.y_ticks = [1E-3 1E-1 1 1E+1 1E+3 1E+5 1E+7 1E+9];
    end

    % Printing
    print_options = struct();
    print_options.print_path = sprintf('out/compare_nm_mds_restarts_rosenbrock_fval_by_dimension_r%d.tex', dim);
    print_options.print_size = [500, 360];

    % Plot
    clf();
    plot_test_case_history_field(test_case, 'fval', plot_options, print_options);
end
