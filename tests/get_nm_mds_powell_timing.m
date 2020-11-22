% Configuration
data_output_dir = 'out/data/';
time_output_dir = 'out/data/timing/';
output_filename = 'out/nm_mds_powell_timing.tex';

% Test cases
test_case.objective = get_objective_func('powell');
test_case.dimensions = [4 8 12 16 20 24 28 32];

test_case.optimizers = struct('func', {});
test_case.optimizers(1).func = @fminsearch_nm;
test_case.optimizers(1).func_name = 'fminsearch_nm';
test_case.optimizers(1).display_name = 'fminsearch\_nm';

test_case.optimizers(2).func = @fminsearch_mds;
test_case.optimizers(2).func_name = 'fminsearch_mds';
test_case.optimizers(2).display_name = 'fminsearch\_mds';

% Open file and create header
file = fopen(output_filename, 'w');
fprintf(file, '\\begin{table}\n');
fprintf(file, '\\centering\n');
fprintf(file, '\\begin{tabular}{|c|c|c|c|c|c|c|c|c|}\n');
fprintf(file, '\\hline\n');
fprintf(file, '\\multirow{2}{*}{$n$} & \\multicolumn{2}{c|}{Iterations ($k$)}             & \\multicolumn{2}{c|}{Evalutions of $f$}              & \\multicolumn{2}{c|}{Execution time}             & \\multicolumn{2}{c|}{$ f(x^k_1) $}              \\\\ \\cline{2-9}\n');
fprintf(file, '                     & NM                     & MDS                    & NM                     & MDS                    & NM                     & MDS                    & NM                     & MDS                    \\\\ \\hline\n');

% Run for all dimensions
dimension_count = size(test_case.dimensions, 2);
for d=1:dimension_count
    dim = test_case.dimensions(d);

    % Get data
    nm_entries = load_test_data(get_output_filename(data_output_dir, test_case.optimizers(1), test_case.objective.func_name, dim));
    nm_time = load_variable(get_output_filename(time_output_dir, test_case.optimizers(1), test_case.objective.func_name, dim), 'average_time');
    nm_final_entry = nm_entries(end);

    mds_entries = load_test_data(get_output_filename(data_output_dir, test_case.optimizers(2), test_case.objective.func_name, dim));
    mds_time = load_variable(get_output_filename(time_output_dir, test_case.optimizers(2), test_case.objective.func_name, dim), 'average_time');
    mds_final_entry = mds_entries(end);

    iters = [nm_final_entry.iter mds_final_entry.iter];
    fcount = [nm_final_entry.fcount mds_final_entry.fcount];
    avg_time = [nm_time mds_time];
    fval = [nm_final_entry.fval mds_final_entry.fval];

    % Print line
    template = '%d & \\multicolumn{1}{r|}{%d} & \\multicolumn{1}{r|}{%d} & \\multicolumn{1}{r|}{%d} & \\multicolumn{1}{r|}{%d} & \\multicolumn{1}{r|}{%.3f s} & \\multicolumn{1}{r|}{%.3f s} & \\multicolumn{1}{r|}{%.3e} & \\multicolumn{1}{r|}{%.3e} \\\\ \\hline\n';
    fprintf(file, template, dim, iters(1), iters(2), fcount(1), fcount(2), avg_time(1), avg_time(2), fval(1), fval(2));

end

% Print table footer
fprintf(file, '\\end{tabular}\n');
fprintf(file, '\\caption{}\n');
fprintf(file, '\\label{}\n');
fprintf(file, '\\end{table}\n');
fclose(file);
