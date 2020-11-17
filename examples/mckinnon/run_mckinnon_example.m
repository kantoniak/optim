function [x, fval, exitflag, output] = run_mckinnon_example(tau, theta, phi, print_path, max_restarts)
% -- [x, fval, exitflag, output] = run_mckinnon_example(tau, theta, phi, print_path, max_restarts)
%
%     Runs minimization of McKinnon function with parameters `tau`, `theta` and
%     `phi` using Nelder-Mead method and gathers various iteration statistics.
%
%     Graph presenting simplex positions will be saved in `print_path`.
%
%     If `max_restarts` is greater than zero, function will run Nelder-Mead
%     variant with oriented restarts enabled (see section 8.1.4. of [2]).
%
%   References:
%     [1] K. I. M. McKinnon, Convergence of the Nelder--Mead Simplex Method to
%         a Nonstationary Point, SIAM Journal on Optimization 9:1, 148–158.
%     [2] C. T. Kelley, Iterative Methods for Optimization, Society for
%         Industrial and Applied Mathematics, Philadelphia, PA, 1999.

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
  plot_options.grid = true;
  plot_options.print_path = print_path;
  plot_options.print_size = [300, 300];
  plot_options.draw_contour = true;
  plot_options.contour_ticks = 201;
  plot_options.contour_lines = [-0.125 0 0.125 0.5 1 2 4 8 16 32 64 128 256];
  plot_options.pre_draw_func = @() draw_axes();

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
