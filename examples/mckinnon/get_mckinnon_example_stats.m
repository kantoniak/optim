function [iters] = get_mckinnon_example_stats(tau, theta, phi, max_restarts)
% -- [iters] = get_mckinnon_example_stats(tau, theta, phi, max_restarts)
%
%     Runs minimization of McKinnon function with parameters `tau`, `theta` and
%     `phi` using Nelder-Mead method and gathers various iteration statistics.
%     Run history is returned in `iters`.
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

  iters = iter_history();
  history_saver = @(x, optimValues, state) save_history(x, optimValues, state, iters);

  options = xoptimset(                                                           ...
      'Display', 'iter',                                                         ...
      'OutputFcn', history_saver,                                                ...
      'InitialSimplex', initial_simplex,                                         ...
      'MaxOrientedRestarts', max_restarts                                        ...
  );

  fminsearch_nm(mckinnon_f, initial_point, options);
  iters = iters.data;
end
