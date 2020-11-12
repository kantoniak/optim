% Plot best function value over iteration separately for each function.
dimensions = [4 8 12 16 20 24 28 32];
output_dir = 'out/data/';
plot_dims = [3 2];

% Optimizers
optimizers = struct('func', {});

optimizers(1).func = @fminsearch_nm;
optimizers(1).func_name = 'fminsearch_nm';
optimizers(1).display_name = 'test function';
optimizers(1).line_style = '-';
optimizers(1).line_width = 0.5;

% Hack second optimizer without objectives to show legend
optimizers(2).func = @fminsearch_nm;
optimizers(2).func_name = 'fminsearch_nm';
optimizers(2).display_name = 'noisy function';
optimizers(2).line_style = '--';
optimizers(2).line_width = 0.5;

% Test cases
test_cases = struct('objective', {});
plot_options = struct('title', {});

% Initialize objectives
case_count = size(test_cases, 2);
for i=1:case_count
    test_cases(i).objective = struct('func', {});
end

% Objective functions
test_cases(1).objective(1) = get_objective_func('squared_l2_norm');
test_cases(2).objective(1) = get_objective_func('penalty_1');
test_cases(3).objective(1) = get_objective_func('powell');
test_cases(4).objective(1) = get_objective_func('rosenbrock');
test_cases(5).objective(1) = get_objective_func('trigonometric');
test_cases(6).objective(1) = get_objective_func('variably_dimensioned');

% Set common settings
case_count = size(test_cases, 2);
for i=1:case_count
    % Initialize case
    test_cases(i).optimizers = optimizers;
    test_cases(i).output_dir = output_dir;

    % Add noisy version
    noisy_objective = make_noisy_objective(test_cases(i).objective(1), 'min');
    fields = fieldnames(noisy_objective);
    for j = 1:size(fields, 1)
        field = char(fields(j));
        test_cases(i).objective(2).(field) = noisy_objective.(field);
    end

    % Set plot options
    plot_options(i).title = test_cases(i).objective(1).display_name;
    if i == plot_dims(2)
        plot_options(i).show_legend = true;
    end
    test_cases(i).objective(2).pre_plot_func = @(field_config) set_struct_field(field_config, 'line_style', '--');
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
    if (dim == 12)
        plot_options(1).y_ticks = [1E-8 1E-6 1E-4 1E-2 1 1E+2 1E+4];
        plot_options(3).y_ticks = [1E-9 1E-7 1E-5 1E-3 1E-1 1E+1 1E+3];
        plot_options(6).y_ticks = [1E-7 1E-5 1E-3 1E-1 1E+1 1E+3 1E+5 1E+7];
    end

    % Printing
    print_options = struct();
    print_options.print_path = sprintf('out/compare_nm_smooth_noisy_fval_by_dimension_r%d.tex', dim);
    print_options.print_size = [500, 720];

    % Plot
    clf();
    plot_test_cases_history_field(test_cases, 'fval', plot_dims, plot_options, print_options);
end
