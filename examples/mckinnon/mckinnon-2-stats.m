% This presents additional iteration statistics for McKinnon example #2 of
% function stagnating in origin. Examples first appeared in [1], at the end of
% section 3.
%
% References:
%   [1] K. I. M. McKinnon, Convergence of the Nelder--Mead Simplex Method to a
%       Nonstationary Point, SIAM Journal on Optimization 9:1, 148–158.

[entries] = get_mckinnon_example_stats(2, 6, 60, 0);
entry_count = size(entries, 2);
field_names = {'sigma_plus', 'scond'};
plot_dims = [1, 2];
plot_options = struct('title', {});

plot_options(1).title = 'Sigma plus';
plot_options(1).x_range = [0 entry_count];

plot_options(2).title = 'Simplex condition';
plot_options(2).x_range = [0 entry_count];

print_options = struct();
print_options.print_path = 'out/mckinnon-2-stats.tex';
print_options.print_size = [500, 150];

plot_history_fields(entries, field_names, plot_dims, plot_options, print_options);
