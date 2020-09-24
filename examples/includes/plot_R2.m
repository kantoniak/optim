function [stop] = plot_R2(x, optimValues, state, plot_options)
% -- [stop] = plot_R2(x, optimValues, state, plot_options)
%
%     Implementation of 'PlotFcns' function. Plots graph of f:R2->R
%     minimization. Displayed elements are:
%
%     • Simplexes (triangles)
%     • Simplex points with best point marked

    switch state
        case 'init'
            orig_x = x;

            % Initialize chart
            hold on
            if ~field_empty(plot_options, 'title')
                title(plot_options.title);
            end
            x_range = plot_options.x_range;
            y_range = plot_options.y_range;
            axis([x_range y_range]);
            pbaspect([plot_options.aspect(:)' 1]);
            set(gca, 'xtick', linspace(x_range(1), x_range(2), plot_options.x_ticks));
            set(gca, 'ytick', linspace(y_range(1), y_range(2), plot_options.y_ticks));
            grid();

            if ~field_empty(plot_options, 'draw_contour')
                XX_linspace = linspace(x_range(1), x_range(2), plot_options.contour_ticks);
                YY_linspace = linspace(y_range(1), y_range(2), plot_options.contour_ticks);
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
            if is_octave() == 1
                print_size = strcat('-S', int2str(plot_options.print_size(1)), ',', int2str(plot_options.print_size(2)));
                print('-depslatex', '-mono', print_size, plot_options.print_path);
            end
    end
    stop = false;
end
