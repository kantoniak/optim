% This presents additional iteration statistics for McKinnon example #1 of
% function which usually stagnates at the origin. Here, with Kelley's oriented
% restarts, function converges to the minimizer. Examples first appeared in
% [1], at the end of section 3.
%
% References:
%   [1] K. I. M. McKinnon, Convergence of the Nelder--Mead Simplex Method to a
%       Nonstationary Point, SIAM Journal on Optimization 9:1, 148–158.

[entries] = get_mckinnon_example_stats(2, 6, 60, 10);
entry_count = size(entries, 2);
field_names = {'f_diff', 'sigma_plus', 'sgrad_norm', 'scond'};
plot_dims = [2, 2];
plot_options = struct('title', {});

plot_options(1).title = 'Function differences';
plot_options(1).x_range = [0 entry_count];
plot_options(1).y_ticks = [1E-9 1E-7 1E-5 1E-3 1E-1 0 1E+1];
plot_options(1).y_range = [1E-9 1E+1];

plot_options(2).title = 'Sigma plus';
plot_options(2).x_range = [0 entry_count];

plot_options(3).title = 'Simplex gradient norm';
plot_options(3).x_range = [0 entry_count];

plot_options(4).title = 'Simplex condition';
plot_options(4).x_range = [0 entry_count];

print_options = struct();
print_options.print_path = 'out/mckinnon-with-restarts-2-stats.tex';
print_options.print_size = [500, 360];

plot_history_fields(entries, field_names, plot_dims, plot_options, print_options);
