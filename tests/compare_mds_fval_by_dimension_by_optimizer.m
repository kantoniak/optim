% Plot best function value over iteration separately for each function.
dimensions = [32 4 8 12 16 20 24 28 32];
output_dir = 'out/data/';
plot_dims = [3 2];

optimizers = struct('func', {});

optimizers(1).func = @fminsearch_mds;
optimizers(1).func_name = 'fminsearch_mds';
optimizers(1).display_name = 'fminsearch\_mds';
optimizers(1).line_style = '-';
optimizers(1).line_width = 0.5;

optimizers(2).func = @mdsmin;
optimizers(2).func_name = 'mdsmin';
optimizers(2).display_name = 'mdsmin';
optimizers(2).line_style = ':';
optimizers(2).line_width = 0.5;

test_cases = struct('func', {});
plot_options = struct('title', {});

% Objective functions
test_cases(1).objective = get_objective_func('squared_l2_norm');
test_cases(2).objective = get_objective_func('penalty_1');
test_cases(3).objective = get_objective_func('powell');
test_cases(4).objective = get_objective_func('rosenbrock');
test_cases(5).objective = get_objective_func('trigonometric');
test_cases(6).objective = get_objective_func('variably_dimensioned');

% Set common settings
case_count = size(test_cases, 2);
for i=1:case_count
    test_cases(i).optimizers = optimizers;
    test_cases(i).output_dir = output_dir;

    plot_options(i).title = test_cases(i).objective.display_name;

    if i == plot_dims(2)
        plot_options(i).show_legend = true;
    end
end

% Run for all dimensions
dimension_count = size(dimensions, 2);
for d=1:dimension_count
    dim = dimensions(d);

    for i=1:case_count
        test_cases(i).dimensions = [dim];

        max_entry_count = get_max_entry_count(test_cases(i));
        plot_options(i).x_range = [0 max_entry_count];
    end

    % Tick corrections
    if (dim == 32)
        plot_options(2).y_ticks = [1E-1 1 1E+1 1E+3 1E+5 1E+7 1E+9];
        plot_options(6).y_ticks = [1 1E+2 1E+4 1E+6 1E+8 1E+10];
    end

    % Printing
    print_options = struct();
    print_options.print_path = sprintf('out/compare_mds_fval_by_dimension_by_optimizer_r%d.tex', dim);
    print_options.print_size = [500, 720];

    % Plot
    plot_test_cases_history_field(test_cases, 'fval', plot_dims, plot_options, print_options);
end
