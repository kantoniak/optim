% This presents additional iteration statistics for McKinnon example #2 of
% function stagnating in origin. Examples first appeared in [1], at the end of
% section 3.
%
% References:
%   [1] K. I. M. McKinnon, Convergence of the Nelder--Mead Simplex Method to a
%       Nonstationary Point, SIAM Journal on Optimization 9:1, 148–158.

[entries] = get_mckinnon_example_stats(2, 6, 60, 10);
entry_count = size(entries, 2);

% Open file and create header
output_filename = 'out/mckinnon-with-restarts-2-table.tex';
file = fopen(output_filename, 'w');
fprintf(file, '\\begin{table}[]\n');
fprintf(file, '\\centering\n');
fprintf(file, '\\begin{tabular}{|c|c|c|c|c|}\n');
fprintf(file, '\\hline\n');
fprintf(file, 'Iteration ($k$) & $ f(x_{n+1}) - f(x_1) $ & $ \\norm{\\sgrad{f}{S}}_2 $ & $ \\sigma_+(S) $ & $ \\cond{V(S)} $ \\\\ \\hline\n');

% Run for all dimensions
for k=1:entry_count

    % Get data
    entry = entries(k);
    iter = entry.iter;
    f_diff = entry.f_diff;
    sgrad_norm = entry.sgrad_norm;
    sigma_plus = entry.sigma_plus;
    scond = entry.scond;

    if (mod(iter, 10) ~= 0)
        continue;
    end

    % Print line
    fprintf(file, '%d & \\multicolumn{1}{r|}{%.3e} & \\multicolumn{1}{r|}{%.2f} & \\multicolumn{1}{r|}{%.3e} & \\multicolumn{1}{r|}{%.3e}', iter, f_diff, sgrad_norm, sigma_plus, scond);
    fprintf(file, ' \\\\ \\hline\n');

end

% Print table footer
fprintf(file, '\\end{tabular}\n');
fprintf(file, '\\end{table}\n');
fclose(file);
