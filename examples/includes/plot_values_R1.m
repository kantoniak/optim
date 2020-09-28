function [stop] = plot_values_R1(x, optimValues, state, plot_options)
% -- [stop] = plot_values_R1(x, optimValues, state, plot_options)
%
%     Implementation of 'PlotFcns' function. Plots graph of f:R->R
%     minimization. Displayed elements are:
%
%     • Function graph
%     • Best point of the simplex

    switch state
        case 'init'
            orig_x = x;

            % Initialize chart
            hold on;
            set_up_plot(plot_options);

            % Plot
            axis_limits = axis();
            X = linspace(axis_limits(1), axis_limits(2), 601);
            plot(X, optimValues.fun(X));

            % Draw initial value
            plot(orig_x, optimValues.fval, 'MarkerSize', 10, 'color', 'red');
            drawnow

        case 'iter'
            % Draw value
            plot(x, optimValues.fval, 'MarkerSize', 10, 'color', 'red');
            drawnow

        case 'done'
            hold off
            print_plot_to_epslatex(plot_options);
    end
    stop = false;
end
