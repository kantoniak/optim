function plot_R3_simplex(X, plot_options)
    % Set up view
    set(gca, 'camerapositionmode', 'manual');
    set(gca, 'cameraposition', plot_options.cam_position);
    set(gca, 'cameratarget', X(:, 1));
    set(gca, 'cameraupvector', [0, 0, 1]);
    set(gca, 'projection', 'perspective');

    pbaspect([1 1 1]);
    axis(plot_options.axes);
    grid();

    % Plot simplex
    plot_edge = @(X, edge) plot3(X(1, edge), X(2, edge), X(3, edge), 'color', 'black', 'linewidth', 2);
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
    if is_octave() == 1
        print_size = strcat('-S', int2str(plot_options.print_size(1)), ',', int2str(plot_options.print_size(2)));
        print('-depslatex', '-mono', print_size, plot_options.print_path);
    end
end
