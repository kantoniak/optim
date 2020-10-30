% Plot best function value over iteration separately for each function.
dimensions = [4];
output_dir = 'out/data/';

optimizers = struct('func', {});
optimizers(1).func = @fminsearch_mds;
optimizers(1).func_name = 'fminsearch_mds';
optimizers(1).display_name = 'fminsearch\_mds';
optimizers(1).line_style = '-';
optimizers(1).line_width = 1.5;
optimizers(2).func = @mdsmin;
optimizers(2).func_name = 'mdsmin';
optimizers(2).display_name = 'mdsmin';
optimizers(2).line_style = ':';
optimizers(2).line_width = 1.5;

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
    test_cases(i).dimensions = dimensions;
    test_cases(i).optimizers = optimizers;
    test_cases(i).output_dir = output_dir;

    max_entry_count = get_max_entry_count(test_cases(i));
    plot_options(i).title = test_cases(i).objective.display_name;
    plot_options(i).x_range = [0 max_entry_count];
    plot_options(i).show_legend = true;
end

% Plot
plot_dims = [3 2];
plot_test_cases_history_field(test_cases, 'fval', plot_dims, plot_options, [])
