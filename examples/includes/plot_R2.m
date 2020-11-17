function [stop] = plot_R2(x, optimValues, state, plot_options)
% -- [stop] = plot_R2(x, optimValues, state, plot_options)
%
%     Implementation of 'PlotFcns' function. Plots graph of f:R2->R
%     minimization. Displayed elements are:
%
%     - Simplices (triangles)
%     - Simplex points with best point marked

    switch state
        case 'init'
            orig_x = x;

            % Initialize chart
            hold on;
            set_up_plot(plot_options);

            % Draw contour if asked to
            if ~field_empty(plot_options, 'draw_contour')
                axis_limits = axis();
                XX_linspace = linspace(axis_limits(1), axis_limits(2), plot_options.contour_ticks);
                YY_linspace = linspace(axis_limits(3), axis_limits(4), plot_options.contour_ticks);
                [XX, YY] = meshgrid(XX_linspace, YY_linspace);
                ZZ = arrayfun(@(x, y) optimValues.fun([x, y]), XX, YY);
                contour(XX, YY, ZZ, plot_options.contour_lines, 'linecolor', 0.6 * [1, 1, 1], 'linestyle', '--');
            end

            % Draw initial simplex
            X = optimValues.simplex_vertices;
            N = size(X, 1);
            plot(orig_x(1), orig_x(2), 'MarkerSize', 10, 'color', 'red');

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
            plot(x(1), x(2), 'MarkerSize', 10, 'color', 'red');

            for i=1:N
                for j=i+1:N+1
                    line([X(1, i), X(1, j)], [X(2, i), X(2, j)], 'color', 'black');
                end
            end
            drawnow

        case 'done'
            hold off
            print_plot(plot_options);
    end
    stop = false;
end
