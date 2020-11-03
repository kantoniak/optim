% Function details
test_case.objective = get_objective_func('penalty_1');
dimensions = [4 8 12 16 20 24 28 32];
output_dir = 'out/data/';
optimizers = get_default_optimizers();

% Noise configuration
pkg load statistics
random_seed = 100;
rho = 1E-4;
eta = 1E-4;

% Objective function
test_cases = struct('func', {});
test_cases(1).objective = get_objective_func('squared_l2_norm');
test_cases(2).objective = get_objective_func('penalty_1');
test_cases(3).objective = get_objective_func('powell');
test_cases(4).objective = get_objective_func('rosenbrock');
test_cases(5).objective = get_objective_func('trigonometric');
test_cases(6).objective = get_objective_func('variably_dimensioned');

case_count = size(test_cases, 2);
for i=1:case_count
    % Set common values
    test_cases(i).dimensions = dimensions;
    test_cases(i).optimizers = optimizers;
    test_cases(i).output_dir = output_dir;

    % Wrap objective function in noise
    test_cases(i).objective.display_name = [test_cases(i).objective.display_name ' (noisy)'];
    test_cases(i).objective.func_name = ['noisy_' test_cases(i).objective.func_name];
    smooth_objective = test_cases(i).objective.func;
    test_cases(i).objective.func = @(V) add_noise(smooth_objective, V, rho, eta);
    test_cases(i).pre_test_func = @() rand('state', random_seed);

    % Run tests
    test_function(test_cases(i));
end
