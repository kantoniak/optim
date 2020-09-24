% This presents McKinnon example #3 of function stagnating in origin. Examples
% first appeared in [1], at the end of section 3.
%
% References:
%   [1] K. I. M. McKinnon, Convergence of the Nelder--Mead Simplex Method to a
%       Nonstationary Point, SIAM Journal on Optimization 9:1, 148–158.

[x, fval, exitflag, output] = run_mckinnon_example(3, 6, 400, 'out/mckinnon-3.tex', 0);
