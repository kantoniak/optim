% McKinnon example function
function [x, fval, exitflag, output] = run_mckinnon_example(tau, theta, phi, print_path, max_restarts)
  initial_point = [0, 0];
  initial_simplex = mckinnon_initial_simplex();
  mckinnon_f = @(x) mckinnon_func(x, tau, theta, phi);

  plot_options = struct();
  plot_options.title = sprintf('McKinnon Example for $ \\tau = %d $, $ \\theta = %d $, $ \\phi = %d $', tau, theta, phi);
  plot_options.x_range = [-0.5, 1.5];
  plot_options.y_range = [-0.8, 1.2];
  plot_options.aspect = [1, 1];
  plot_options.x_ticks = 11;
  plot_options.y_ticks = 11;
  plot_options.print_path = print_path;
  plot_options.print_size = [300, 300];
  plot_options.draw_contour = true;
  plot_options.contour_ticks = 201;
  plot_options.contour_lines = [-0.125 0 0.125 0.5 1 2 4 8 16 32 64 128 256];

  mkdir('out');
  plotter = @(x, optimValues, state) plot_R2(x, optimValues, state, plot_options);

  options = xoptimset(                                                           ...
      'Display', 'iter',                                                         ...
      'OutputFcn', plotter,                                                      ...
      'InitialSimplex', initial_simplex,                                         ...
      'MaxOrientedRestarts', max_restarts                                        ...
  );

  [x, fval, exitflag, output] = fminsearch_nm(mckinnon_f, initial_point, options);
end
