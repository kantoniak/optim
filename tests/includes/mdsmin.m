function [x, fval, exitflag, output] = mdsmin(varargin)
% -- mdsmin(varargin)
%
%     Adapter code for using `mdsmax` from package `optim` from Octave Forge.
%     Code copied from Octave's `fminsearch` implementation.

  if is_octave()
    pkg load optim;
  end

  if (nargin < 1)
    print_usage();
  end

  % Get default options if requested.
  if (nargin == 1 && ischar (varargin{1}) && strcmp (varargin{1}, "defaults"))
    x = struct ("Display", "notify", "FunValCheck", "off",                     ...
                "MaxFunEvals", [], "MaxIter", [],                              ...
                "OutputFcn", [],                                               ...
                "TolFun", 1e-4, "TolX", 1e-4);
    return;
  end

  if (nargin == 1)
    problem = varargin{1};
    varargin = {};
    if (~isstruct (problem))
      error ("fminsearch: PROBLEM must be a structure");
    end
    fun = problem.objective;
    x0 = problem.x0;
    if (~strcmp (problem.solver, "fminsearch"))
      error ('fminsearch: problem.solver must be set to "fminsearch"');
    end
    if (isfield (problem, "options"))
      options = problem.options;
    else
      options = [];
    end
  elseif (nargin > 1)
    fun = varargin{1};
    x0 = varargin{2};
    if (nargin > 2)
      options = varargin{3};
      varargin(1:3) = [];
    else
      options = [];
      varargin = {};
    end
  end

  if (isempty (options))
    options = struct ();
  end

  [x, exitflag, output] = mdsmax(fun, x0, options, varargin{:});
  fval = feval (fun, x);

end
