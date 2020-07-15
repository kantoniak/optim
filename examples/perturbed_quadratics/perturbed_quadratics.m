% This presents sample perturbed quadratic function \hat{f}_2 from [1].
%
% References:
%   [1] P. Gilmore and C. T. Kelley, An implicit filtering algorithm for
%       optimization of functions with many local minima, SIAM Journal on
%       Optimization 5:2, 269–285.

perturbed_quadratic_func = @(x) (x.^2) .* (1+0.75*cos(80*x)/20) + (cos(100*x).^2)/80;

plot_options = struct();
plot_options.title = '$ x^2(1 + 0.75 \cos(80x)/20) + cos(100x)^2/80 $';
plot_options.x_range = [-2, 2];
plot_options.y_range = [0, 4];
plot_options.aspect = [1, 1];
plot_options.x_ticks = 11;
plot_options.y_ticks = 11;
plot_options.print_path = 'out/perturbed-quadratics.tex';
plot_options.print_size = [600, 600];

mkdir('out');
plotter = @(x, optimValues, state) plot_values_R1(x, optimValues, state, plot_options);

options = xoptimset(                                                           ...
    'Display', 'iter',                                                         ...
    'OutputFcn', plotter                                                       ...
);
[x, fval, exitflag, output] = fminsearch_nm(perturbed_quadratic_func, [1.6], options);
