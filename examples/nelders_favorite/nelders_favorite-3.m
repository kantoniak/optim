% This examples presents one of Nelder's favorite examples, as described in [1]
% (see Excercise 8.6.1).
%
% References:
%   [1] Kelley, Carl T. Iterative methods for optimization. Society for
%       Industrial and Applied Mathematics, 1999.

initial_point = ones(4, 1) * 10;
initial_simplex = nelders_favorite_initial_simplex([2, 2, 2, 2]);
func = @nelders_favorite_func;

options = xoptimset(                                                           ...
    'Display', 'iter',                                                         ...
    'InitialSimplex', initial_simplex                                          ...
);
[x, fval, exitflag, output] = fminsearch_nm(func, initial_point, options);
