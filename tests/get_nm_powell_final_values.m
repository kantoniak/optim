% Configuration
output_filename = 'out/nm_powell_final_values.tex';

test_case.objective = get_objective_func('powell');
test_case.dimensions = [4 8 12 16 20 24 28 32];
test_case.output_dir = 'out/data/';
test_case.optimizers(1).func = @fminsearch_nm;
test_case.optimizers(1).func_name = 'fminsearch_nm';
test_case.optimizers(1).display_name = 'fminsearch\_nm';
test_case.optimizers(1).line_style = '-';
test_case.optimizers(1).line_width = 0.5;

% Open file and create header
file = fopen(output_filename, 'w');
fprintf(file, '\\begin{table}[]\n');
fprintf(file, '\\centering\n');
fprintf(file, '\\begin{tabular}{|c|c|c|c|c|}\n');
fprintf(file, '\\hline\n');
fprintf(file, '$n$ & Iterations ($k$) & Evaluations of $f$ & $ \\norm{x^k_1} $ & $ f(x^k_1) $ \\\\ \\hline\n');

% Run for all dimensions
dimension_count = size(test_case.dimensions, 2);
for d=1:dimension_count
    dim = test_case.dimensions(d);

    % Get data
    filename = get_output_filename(test_case.output_dir, test_case.optimizers(1), test_case.objective.func_name, dim);
    entries = load_test_data(filename);

    final_entry = entries(end);
    iters = final_entry.iter;
    fcount = final_entry.fcount;
    x_norm = norm(final_entry.x, 2);
    fval = final_entry.fval;

    % Print line
    fprintf(file, '%d & \\multicolumn{1}{r|}{%d} & \\multicolumn{1}{r|}{%d} & \\multicolumn{1}{r|}{%.12f} & \\multicolumn{1}{r|}{%.12f}', dim, iters, fcount, x_norm, fval);
    fprintf(file, ' \\\\ \\hline\n');

end

% Print table footer
fprintf(file, '\\end{tabular}\n');
fprintf(file, '\\end{table}\n');
fclose(file);
