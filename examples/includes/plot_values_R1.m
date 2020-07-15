function [stop] = plot_values_R1(x, optimValues, state, plot_options)
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

            % Plot function
            X = linspace(x_range(1), x_range(2), 601);
            plot(X, optimValues.fun(X));

            % Draw initial value
            plot(orig_x, optimValues.fval, 'MarkerSize', 20, 'color', 'red');
            drawnow

        case 'iter'
            % Draw value
            plot(x, optimValues.fval, 'MarkerSize', 20, 'color', 'red');
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
