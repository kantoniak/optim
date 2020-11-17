function plot_R3_simplex(X, plot_options)
% -- plot_R3_simplex(X, plot_options)
%
%     Plots simplex in R3 space. Uses plotting settings from `plot_options`.

    % Set up view
    set(gca, 'camerapositionmode', 'manual');
    set(gca, 'cameraposition', plot_options.cam_position);
    set(gca, 'cameratarget', X(:, 1));
    set(gca, 'cameraupvector', [0, 0, 1]);
    set(gca, 'projection', 'perspective');

    set(gca, 'xtick', linspace(plot_options.x_range(1), plot_options.x_range(2), plot_options.x_ticks));
    set(gca, 'ytick', linspace(plot_options.y_range(1), plot_options.y_range(2), plot_options.y_ticks));
    set(gca, 'ztick', linspace(plot_options.z_range(1), plot_options.z_range(2), plot_options.z_ticks));
    pbaspect([1 1 1]);
    axis([plot_options.x_range plot_options.y_range plot_options.z_range]);
    grid();

    % Plot simplex
    plot_edge = @(X, edge) plot3(X(1, edge), X(2, edge), X(3, edge), 'color', 'black', 'linewidth', 1);
    hold on
        if ~field_empty(plot_options, 'title')
            title(plot_options.title);
        end

        plot_edge(X, [1 2]);
        plot_edge(X, [1 3]);
        plot_edge(X, [1 4]);
        plot_edge(X, [2 3]);
        plot_edge(X, [2 4]);
        plot_edge(X, [3 4]);
    hold off

    % Print to file
    print_plot(plot_options);
end
