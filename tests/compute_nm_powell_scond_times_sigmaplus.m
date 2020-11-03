% Set up test case
test_case.objective = get_objective_func('powell');
test_case.dimensions = [4 8 12 16 20 24 28 32];
test_case.output_dir = 'out/data/';
test_case.optimizers(1).func = @fminsearch_nm;
test_case.optimizers(1).func_name = 'fminsearch_nm';
test_case.optimizers(1).display_name = 'fminsearch\_nm';
test_case.optimizers(1).line_style = '-';
test_case.optimizers(1).line_width = 0.5;

entries = [];
entries2 = [];
filename = '';

for i=1:size(test_case.dimensions(:), 1)
    n = test_case.dimensions(i);
    for j=1:size(test_case.optimizers, 2)
        % Load entries
        optimizer = test_case.optimizers(j);
        filename = get_output_filename(test_case.output_dir, optimizer, test_case.objective.func_name, n);
        entries = load_test_data(filename);

        % Enrich data
        for k=1:size(entries, 2)
            entries(k).sigmaplus_scond = entries(k).sigma_plus * entries(k).scond;
        end

        % Save data
        iters = entries;
        save(filename, 'iters');
        entries2 = load_test_data(filename);
    end
end
