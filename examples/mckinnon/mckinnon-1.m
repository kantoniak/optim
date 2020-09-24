% This presents McKinnon example #1 of function stagnating in origin. Examples
% first appeared in [1], at the end of section 3.
%
% References:
%   [1] K. I. M. McKinnon, Convergence of the Nelder--Mead Simplex Method to a
%       Nonstationary Point, SIAM Journal on Optimization 9:1, 148–158.

[x, fval, exitflag, output] = run_mckinnon_example(1, 15, 10, 'out/mckinnon-1.tex', 0);
