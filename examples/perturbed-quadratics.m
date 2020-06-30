% This presents sample perturbed quadratic function \hat{f}_2 from [1].
%
% References:
%   [1] P. Gilmore and C. T. Kelley, An implicit filtering algorithm for
%       optimization of functions with many local minima, SIAM Journal on
%       Optimization 5:2, 269–285.
clear;

perturbed_quadratic_func = @(x) (x.^2) .* (1+0.75*cos(80*x)/20) + (cos(100*x).^2)/80;

% Helper plotting function
function [stop] = value_plotter(x, optimValues, state)

    switch state
        case 'init'
            orig_x = x;

            % Initialize chart
            hold on
            title('$ x^2(1 + 0.75 \cos(80x)/20) + cos(100x)^2/80 $');
            x_range = [-2, 2];
            y_range = [0, 4];
            axis([x_range y_range], "square");
            set(gca, 'xtick', linspace(x_range(1), x_range(2), 11));
            set(gca, 'ytick', linspace(y_range(1), y_range(2), 11));
            grid();

            % Plot function
            X = linspace(x_range(1), x_range(2), 601);
            plot(X, optimValues.fun(X));

            % Draw initial simplex
            plot(orig_x, optimValues.fval, 'MarkerSize', 20, 'color', 'red');
            drawnow

        case 'iter'
            % Draw simplex
            plot(x, optimValues.fval, 'MarkerSize', 20, 'color', 'red');
            drawnow

        case 'done'
            hold off
            print -depslatex -mono "-S600,600" "out/perturbed-quadratics-clean.tex"
    end

    stop = false;
end

options = optimset(
    'Display', 'iter',
    'OutputFcn', @value_plotter
);
[x, fval, exitflag, output] = fminsearch_nm(perturbed_quadratic_func, [1.6], options);
