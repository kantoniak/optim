% This presents sample perturbed quadratic function \hat{f}_2 from [1].
%
% References:
%   [1] P. Gilmore and C. T. Kelley, An implicit filtering algorithm for
%       optimization of functions with many local minima, SIAM Journal on
%       Optimization 5:2, 269–285.

perturbed_quadratic_func = @(x) (x.^2) .* (1+0.75*cos(80*x)/20) + (cos(100*x).^2)/80;

options = suppress_warnings(@() optimset(          ...
    'Display', 'iter',                             ...
    'OutputFcn', @value_plotter                    ...
));
[x, fval, exitflag, output] = fminsearch_nm(perturbed_quadratic_func, [1.6], options);
