% This presents McKinnon examples of function stagnating in origin. Examples
% first appeared in [1].
%
% References:
%   [1] K. I. M. McKinnon, Convergence of the Nelder--Mead Simplex Method to a
%       Nonstationary Point, SIAM Journal on Optimization 9:1, 148–158.

mckinnon_f1 = @(x) mckinnon_func(x, 3, 6, 400);
mckinnon_f2 = @(x) mckinnon_func(x, 2, 6, 60);
mckinnon_f3 = @(x) mckinnon_func(x, 1, 15, 10);

plot_options = struct();
plot_options.title = 'McKinnon Example for $ \tau = 2 $, $ \theta = 6 $, $ \phi = 60 $';
plot_options.x_range = [-0.5, 1.5];
plot_options.y_range = [-0.8, 1.2];
plot_options.aspect = [1, 1];
plot_options.x_ticks = 11;
plot_options.y_ticks = 11;
plot_options.print_path = 'out/mckinnon-1.tex';
plot_options.print_size = [800, 600];

mkdir('out');
plotter = @(x, optimValues, state) plot_R2(x, optimValues, state, plot_options);

options = xoptimset(                                                           ...
    'Display', 'iter',                                                         ...
    'OutputFcn', plotter,                                                      ...
    'InitialSimplex', mckinnon_initial_simplex()                               ...
);

[x, fval, exitflag, output] = fminsearch_nm(mckinnon_f2, [0, 0], options);
