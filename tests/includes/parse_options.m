function [stopit, savit, dirn, trace, tol, maxiter, tol_f, outfcn] = ...
                                                     parse_options (options, x)
% -- [stopit, savit, dirn, trace, tol, maxiter, tol_f, outfcn] = ...
%                                                    parse_options (options, x)
%
%     Original `parse_options` implementation from `mdsmax`, modified for
%     Matlab cooperability.

  % Tolerance for cgce test based on relative size of simplex.
  tol = optimget (options, "TolX", 1e-4);
  stopit(1) = tol;

  % Tolerance for cgce test based on step in function value.
  tol_f = optimget (options, "TolFun", 1e-4);

  % Max number of function evaluations.
  stopit(2) = optimget (options, "MaxFunEvals", 200 * length (x));

  % Max number of iterations
  maxiter = optimget (options, "MaxIter", 200 * length (x));

  % Default target for function values.
  stopit(3) = Inf;  % FIXME: expose this parameter to the outside

  % Default initial simplex.
  stopit(4) = 0;    % FIXME: expose this parameter to the outside

  % Default: show progress.
  display = optimget (options, "Display", "notify");
  switch (display)
    case "iter"
      stopit(5) = 1;
    case "final"
      stopit(5) = 2;
    case "notify"
      stopit(5) = 3;
    otherwise  % "none"
      stopit(5) = 0;
  end
  trace = stopit(5);

  % Use function to minimize, not maximize
  dirn = -1;
  stopit(6) = dirn;

  % Filename for snapshots.
  savit = [];  % FIXME: expose this parameter to the outside

  % OutputFcn
  outfcn = optimget (options, "OutputFcn");

end
