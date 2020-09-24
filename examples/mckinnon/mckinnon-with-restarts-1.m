% This presents McKinnon example #1 of function which usually stagnates at the
% origin. Here, with Kelley's oriented restarts, function converges to the
% minimizer. Examples first appeared in [1], at the end of section 3.
%
% References:
%   [1] K. I. M. McKinnon, Convergence of the Nelder--Mead Simplex Method to a
%       Nonstationary Point, SIAM Journal on Optimization 9:1, 148–158.

[x, fval, exitflag, output] = run_mckinnon_example(1, 15, 10, 'out/mckinnon-with-restarts-1.tex', 10);
