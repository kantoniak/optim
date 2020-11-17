function set_up_plot(plot_options)
% -- set_up_plot(plot_options)
%
%     Initializes chart area using `plot_options`.

    % Chart title
    if ~field_empty(plot_options, 'title')
        title(plot_options.title);
    end

    % Axis limits
    if ~field_empty(plot_options, 'x_range')
        xlim(plot_options.x_range(:));
    end
    if ~field_empty(plot_options, 'y_range')
        ylim(plot_options.y_range(:));
    end

    % Axis ticks
    if ~field_empty(plot_options, 'x_ticks')
        if isscalar(plot_options.x_ticks)
            xrange = xlim();
            set(gca, 'xtick', linspace(xrange(1), xrange(2), plot_options.x_ticks));
        else
            set(gca, 'xtick', plot_options.x_ticks);
        end
    end
    if ~field_empty(plot_options, 'y_ticks')
        if isscalar(plot_options.y_ticks)
            yrange = ylim();
            set(gca, 'ytick', linspace(yrange(1), yrange(2), plot_options.y_ticks));
        else
            set(gca, 'ytick', plot_options.y_ticks);
        end
    end

    % Axis aspect ratio
    if ~field_empty(plot_options, 'aspect')
        pbaspect([plot_options.aspect(:)' 1]);
    end

    % Grid
    if ~field_empty(plot_options, 'grid') && plot_options.grid == true
        grid();
    end

    % Pre-draw function
    if ~field_empty(plot_options, 'pre_draw_func')
        plot_options.pre_draw_func();
    end
end
