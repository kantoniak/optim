% McKinnon example function
function [iters] = get_mckinnon_example_stats(tau, theta, phi, max_restarts)
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
