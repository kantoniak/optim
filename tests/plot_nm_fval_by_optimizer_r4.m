% Plot best function value over iteration separately for each function.
dimensions = [16];
output_dir = 'out/data/';

optimizers = struct('func', {});
optimizers(1).func = @fminsearch;
optimizers(1).func_name = 'fminsearch';
optimizers(1).display_name = 'fminsearch';
optimizers(1).line_style = ':';
optimizers(1).line_width = 0.5;
optimizers(2).func = @fminsearch_nm;
optimizers(2).func_name = 'fminsearch_nm';
optimizers(2).display_name = 'fminsearch\_nm';
optimizers(2).line_style = '-';
optimizers(2).line_width = 0.5;

test_cases = struct('func', {});
plot_options = struct('title', {});

% Squared l2 norm
test_cases(1).objective = get_objective_func('squared_l2_norm');
test_cases(1).dimensions = dimensions;
test_cases(1).optimizers = optimizers;
test_cases(1).output_dir = output_dir;

max_entry_count = get_max_entry_count(test_cases(1));
plot_options(1).title = 'Squared l2 norm';
plot_options(1).x_range = [0 max_entry_count];
plot_options(1).show_legend = false;

% Penalty I norm
test_cases(2).objective = get_objective_func('penalty_1');
test_cases(2).dimensions = dimensions;
test_cases(2).optimizers = optimizers;
test_cases(2).output_dir = output_dir;

max_entry_count = get_max_entry_count(test_cases(2));
plot_options(2).title = 'Penalty I function';
plot_options(2).x_range = [0 max_entry_count];
plot_options(2).show_legend = false;

% Powell function
test_cases(3).objective = get_objective_func('powell');
test_cases(3).dimensions = dimensions;
test_cases(3).optimizers = optimizers;
test_cases(3).output_dir = output_dir;

max_entry_count = get_max_entry_count(test_cases(3));
plot_options(3).title = 'Powell function';
plot_options(3).x_range = [0 max_entry_count];
plot_options(3).show_legend = false;

% Rosenbrock function
test_cases(4).objective = get_objective_func('rosenbrock');
test_cases(4).dimensions = dimensions;
test_cases(4).optimizers = optimizers;
test_cases(4).output_dir = output_dir;

max_entry_count = get_max_entry_count(test_cases(4));
plot_options(4).title = 'Rosenbrock function';
plot_options(4).x_range = [0 max_entry_count];
plot_options(4).show_legend = false;

% Trigonometric function
test_cases(5).objective = get_objective_func('trigonometric');
test_cases(5).dimensions = dimensions;
test_cases(5).optimizers = optimizers;
test_cases(5).output_dir = output_dir;

max_entry_count = get_max_entry_count(test_cases(5));
plot_options(5).title = 'Trigonometric function';
plot_options(5).x_range = [0 max_entry_count];
plot_options(5).show_legend = false;

% Variably dimensioned function
test_cases(6).objective = get_objective_func('variably_dimensioned');
test_cases(6).dimensions = dimensions;
test_cases(6).optimizers = optimizers;
test_cases(6).output_dir = output_dir;

max_entry_count = get_max_entry_count(test_cases(6));
plot_options(6).title = 'Variably dimensioned function';
plot_options(6).x_range = [0 max_entry_count];
plot_options(6).show_legend = false;

% Plot
plot_dims = [3 2];
plot_test_cases_history_field(test_cases, 'fval', plot_dims, plot_options, [])
