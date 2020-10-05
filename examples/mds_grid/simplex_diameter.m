% Compute simplex diameter.
function [diam] = simplex_diameter(X)

    diam = -inf;

    N = size(X, 2)-1;
    for i=1:N
        for j=i+1:N+1
            a = abs(X(1, i) - X(1, j));
            b = abs(X(2, i) - X(2, j));
            dist = sqrt(a^2 + b^2);
            if (dist > diam)
                diam = dist;
            end
        end
    end
end
