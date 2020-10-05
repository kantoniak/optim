% Check if triangle is in provided rect.
function [in_rect] = triangle_in_rect(X, rect)

    N = size(X, 2)-1;
    in_rect = true;

    % Set bounds
    x_min = rect(1);
    x_max = rect(2);
    y_min = rect(3);
    y_max = rect(4);

    % Test containment
    for i=1:(N+1)
        if (X(1, i) < x_min || x_max < X(1, i) || X(2, i) < y_min || y_max < X(2, i))
            in_rect = false;
            return;
        end;
    end
end
