function [stop] = plot_R1(x, optimValues, state, plot_options)
% -- [stop] = plot_R1(x, optimValues, state, plot_options)
%
%     Implementation of 'PlotFcns' function. Plots graph of f:R->R
%     minimization. Displayed elements are:
%
%     • Function graph
%     • Simplices (lines)
%     • Simplex points with best point marked

    switch state
        case 'init'
            orig_x = x;

            % Initialize chart
            hold on;
            set_up_plot(plot_options);

            % Plot function
            axis_limits = axis();
            X = linspace(axis_limits(1), axis_limits(2), 601);
            plot(X, optimValues.fun(X));

            % Draw initial simplex
            X = optimValues.simplex_vertices;
            f = optimValues.fun(X);
            line([X(1), X(2)], [f(1), f(2)], 'color', 'black');
            plot(X(1), f(1), 'MarkerSize', 10, 'color', 'red');
            plot(X(2), f(2), 'MarkerSize', 10, 'color', 'black');
            drawnow

        case 'iter'
            % Draw value
            X = optimValues.simplex_vertices;
            f = optimValues.fun(X);
            line([X(1), X(2)], [f(1), f(2)], 'color', 'black');
            plot(X(1), f(1), 'MarkerSize', 10, 'color', 'red');
            plot(X(2), f(2), 'MarkerSize', 10, 'color', 'black');
            drawnow

        case 'done'
            hold off
            print_plot(plot_options);
    end
    stop = false;
end
