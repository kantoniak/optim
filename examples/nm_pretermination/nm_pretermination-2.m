% This presents an example of premature termination of Nelder-Mead algorithm
% when used with original halting criterion. Examples inspired by [1], section
% 2.4.
%
% References:
%   [1] Woods, D. J. (1985). An interactive approach for solving
%       multi-objective optimization problems.

cutting_point = 0.13;
scaling_factor = 0.2;
s = sin(1/cutting_point) * scaling_factor;
deriv = -scaling_factor * cos(1/cutting_point) / (cutting_point^2);
func = @(x) (x < cutting_point) .* (s + (x - cutting_point).*deriv) + (cutting_point <= x) .* sin(1./x) * scaling_factor;

maximizer = 2/pi;
initial_point = [maximizer - 0.025];
initial_simplex = [-0.025, 0.025] .+ maximizer;

plot_options = struct();
plot_options.title = '$ Premature NM termination with SE test $';
plot_options.x_range = [-0.05, 0.05] .+ maximizer;
plot_options.y_range = [0.15, 0.25];
plot_options.aspect = [1, 1];
plot_options.x_ticks = 11;
plot_options.y_ticks = 11;
plot_options.print_path = 'out/nm_pretermination-2.tex';
plot_options.print_size = [600, 600];

mkdir('out');
plotter = @(x, optimValues, state) plot_R1(x, optimValues, state, plot_options);

options = xoptimset(                                                           ...
    'HaltingTest', 1,                                                          ...
    'Display', 'iter',                                                         ...
    'OutputFcn', plotter,                                                      ...
    'InitialSimplex', initial_simplex,                                         ...
    'TolFun', 1e-2                                                             ...
);
[x, fval, exitflag, output] = fminsearch_nm(func, initial_point, options);
