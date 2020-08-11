% This presents sample NM iterations on Rosenbrock valley function.

plot_options = struct();
plot_options.title = 'Rosenbrock Valley ($ a = 1, b = 100 $)';
plot_options.x_range = [-2, 2];
plot_options.y_range = [-1.6, 2.4];
plot_options.aspect = [1, 1];
plot_options.x_ticks = 11;
plot_options.y_ticks = 11;
plot_options.draw_contour = true;
plot_options.contour_ticks = 101;
plot_options.contour_lines = 20;
plot_options.print_path = 'out/nm.tex';
plot_options.print_size = [800, 600];

mkdir('out');
plotter = @(x, optimValues, state) plot_R2(x, optimValues, state, plot_options);

options = xoptimset(                                                           ...
    'Display', 'iter',                                                         ...
    'InitialSimplexStrategy', 2,                                               ...
    'OutputFcn', plotter
);

initial_point = [-1.6, -1.2];
[x, fval, exitflag, output] = fminsearch_nm(@(x) rosenbrock_func(x, 1, 100), initial_point, options);
