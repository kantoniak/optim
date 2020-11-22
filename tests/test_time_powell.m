% Function details
test_case.objective = get_objective_func('powell');
test_case.dimensions = [4 8 12 16 20 24 28 32];
test_case.output_dir = 'out/data/timing/';

% Set up optimizers
test_case.optimizers = struct('func', {});
test_case.optimizers(1).func = @fminsearch_nm;
test_case.optimizers(1).func_name = 'fminsearch_nm';
test_case.optimizers(1).display_name = 'fminsearch\_nm';

test_case.optimizers(2).func = @fminsearch_mds;
test_case.optimizers(2).func_name = 'fminsearch_mds';
test_case.optimizers(2).display_name = 'fminsearch\_mds';

test_function_time(test_case, 10);
