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
            pbaspect ([1 1 1]);
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
                mkdir('out');
                print('-depslatex', '-mono', '-S800,600', 'out/mckinnon-example-mds.tex');
            end
    end

    stop = false;
end
