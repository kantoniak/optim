% This presents McKinnon examples of function stagnating in origin. Examples
% first appeared in [1].
%
% References:
%   [1] K. I. M. McKinnon, Convergence of the Nelder--Mead Simplex Method to a
%       Nonstationary Point, SIAM Journal on Optimization 9:1, 148–158.
addpath('../includes');

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
        'OutputFcn', @value_plotter,                   ...
    ));
end
[x, fval, exitflag, output] = fminsearch_nm(mckinnon_f2, [0, 0], options);

% McKinnon example function
function ret = mckinnon_func(x, tau, theta, phi)
  if x(1) > 0
    ret = (x(1) .^ tau) * theta + x(2) + (x(2) .^ 2);
  else
    ret = ((abs(x(1)) .^ tau) * theta * phi) + x(2) + (x(2) .^ 2);
  end
end

% McKinnon initial simplex
function [X] = mckinnon_initial_simplex()
  lambda_plus = (1 + sqrt(33)) / 8;
  lambda_minus = (1 - sqrt(33)) / 8;
  X(:,1) = [1; 1];
  X(:,2) = [lambda_plus; lambda_minus];
  X(:,3) = [0; 0];
end

% Helper plotting function
function [stop] = value_plotter(x, optimValues, state)

    switch state
        case 'init'
            orig_x = x;

            % Initialize chart
            hold on
            title('McKinnon Example for $ \tau = 2 $, $ \theta = 6 $, $ \phi = 60 $');
            x_range = [-0.5, 1.5];
            y_range = [-0.8, 1.2];
            axis([x_range y_range]);
            set(gca, 'xtick', linspace(x_range(1), x_range(2), 11));
            set(gca, 'ytick', linspace(y_range(1), y_range(2), 11));
            grid();

            % Draw initial simplex
            X = optimValues.simplex_vertices;
            N = size(X, 1);
            plot(orig_x(1), orig_x(2), 'MarkerSize', 20, 'color', 'red');

            for i=1:N
                for j=i+1:N+1
                    line([X(1, i), X(1, j)], [X(2, i), X(2, j)], 'color', 'black');
                end
            end
            drawnow

        case 'iter'
            % Draw simplex
            X = optimValues.simplex_vertices;
            N = size(X, 1);
            plot(x(1), x(2), 'MarkerSize', 20, 'color', 'red');

            for i=1:N
                for j=i+1:N+1
                    line([X(1, i), X(1, j)], [X(2, i), X(2, j)], 'color', 'black');
                end
            end
            drawnow

        case 'done'
            hold off
            if is_octave() ~= 0
                print('-depslatex', '-mono', '-S800,600' 'out/mckinnon-example-mds.tex');
            else
    end

    stop = false;
end
