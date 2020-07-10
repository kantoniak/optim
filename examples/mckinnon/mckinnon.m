% This presents McKinnon examples of function stagnating in origin. Examples
% first appeared in [1].
%
% References:
%   [1] K. I. M. McKinnon, Convergence of the Nelder--Mead Simplex Method to a
%       Nonstationary Point, SIAM Journal on Optimization 9:1, 148–158.

mckinnon_f1 = @(x) mckinnon_func(x, 3, 6, 400);
mckinnon_f2 = @(x) mckinnon_func(x, 2, 6, 60);
mckinnon_f3 = @(x) mckinnon_func(x, 1, 15, 10);

% FIXME: Matlab does not support custom options and this example does not work
% as intended
if is_octave() ~= 0
    options = suppress_warnings(@() optimset(          ...
        'Display', 'iter',                             ...
        'OutputFcn', @value_plotter,                   ...
        'InitialSimplex', mckinnon_initial_simplex()   ...
    ));
else
    options = suppress_warnings(@() optimset(          ...
        'Display', 'iter',                             ...
        'OutputFcn', @value_plotter                    ...
    ));
end
[x, fval, exitflag, output] = fminsearch_nm(mckinnon_f2, [0, 0], options);
