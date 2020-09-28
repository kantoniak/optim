% Initializes chart area.
function set_up_plot(plot_options)

    % Chart title
    if ~field_empty(plot_options, 'title')
        title(plot_options.title);
    end

    % Axis limits
    axis_limits = axis();
    if ~field_empty(plot_options, 'x_range')
        axis_limits(1:2) = plot_options.x_range(:);
        axis(axis_limits);
    end
    if ~field_empty(plot_options, 'y_range')
        axis_limits(3:4) = plot_options.y_range(:);
        axis(axis_limits);
    end

    % Axis ticks
    if ~field_empty(plot_options, 'x_ticks')
        set(gca, 'xtick', linspace(axis_limits(1), axis_limits(2), plot_options.x_ticks));
    end
    if ~field_empty(plot_options, 'y_ticks')
        set(gca, 'ytick', linspace(axis_limits(3), axis_limits(4), plot_options.y_ticks));
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
