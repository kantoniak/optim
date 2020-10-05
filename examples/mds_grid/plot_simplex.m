% Plot triangle defined in matrix X.
function [discard_simplex] = plot_simplex(X, discard_test, hide_lines, data_color, line_width)

    if ~exist('hide_lines', 'var')
        hide_lines = false;
    end

    if ~exist('data_color', 'var')
        data_color = 0.3 * [1, 1, 1];
    end

    if ~exist('line_width', 'var')
        line_width = 0.5;
    end

    % Test discarding
    discard_simplex = false;
    if discard_test(X)
        discard_simplex = true;
        return;
    end

    N = size(X, 2)-1;


    % Draw lines
    if (~hide_lines)
        for i=1:N
            for j=i+1:N+1
                line([X(1, i), X(1, j)], [X(2, i), X(2, j)], 'color', data_color, 'linewidth', line_width);
            end
        end
    end

    % Draw points
    scatter(X(1, :), X(2, :), 3, 'markerfacecolor', data_color, 'linewidth', line_width, 'filled');
end
