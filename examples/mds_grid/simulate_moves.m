% Simulate all MDS operations with maximum `move_count` moves from X.
function [points] = simulate_moves(X, move_count, simplex_func)
    N = size(X, 2)-1;
    points = [];

    % Transformation coefficients
    mu_e  =  2.0;    % expansion
    mu_c  =  0.5;    % contraction

    moves_loop(X, move_count, '');
    points = unique(points', 'rows')';

    function moves_loop(X, moves_left, prev_action)
        % Save simplex points
        points = [points X];
        discard_simplex = simplex_func(X);

        if (moves_left == 0 || discard_simplex)
            return;
        end

        % Select all vertices as starting ones
        for i = 1:(N+1)

            % Set up simplex vertices
            x_1 = X(:, i);
            X_others = X;
            X_others(:, i) = [];

            % Reflect
            R(:, 1) = x_1;
            for j=1:N
                R(:, j+1) = 2*x_1 - X_others(:, j);
            end
            moves_loop(R, moves_left - 1, 'reflect');

            % Expand
            E(:, 1) = x_1;
            for j=1:N
                E(:, j+1) = (1+mu_e)*x_1 - mu_e*X_others(:, j);
            end
            moves_loop(E, moves_left - 1, 'expand');

            % Shrink
            S(:, 1) = x_1;
            for j=1:N
                S(:, j+1) = (1-mu_c)*x_1 + mu_c*X_others(:, j);
            end
            moves_loop(S, moves_left - 1, 'shrink');

        end
    end
end
