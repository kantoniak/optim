function [sgrad] = simplex_gradient(X, f)
% -- [sgrad] = simplex_gradient(X, f)
%
%     Compute simplex gradient using precomputed function values.

    f_diff = f(2:end) - f(1);
    V = X(:,2:end) - X(:,1);
    sgrad = V' \ f_diff';
end
