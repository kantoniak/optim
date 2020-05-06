1; % Make file executable

function [sigma_plus] = simplex_max_oriented_length(S)
% -- [sigma_plus] = simplex_max_oriented_length(S)
%
%     Compute max oriented length of a simplex S. Simplex points are
%     represented as matrix columns.
    N = size(S)(1);
    V = S(:, 2:N+1) - S(:, ones(1,N));
    sigma_plus = max(max(abs(V)));
end

% Reflect `x` about `y` with coefficient `mu`
function [z] = reflect_about(x, y, mu)
    z = (1 + mu)*y - mu*x;
end

% Sort `f` and apply the same permutation to columns of `X`
function [Xs, fs] = sort_by_values(X, f)
    [~, i] = sort(f);    % I holds sorting order
    Xs = X(:,i);         % apply this order to vector
    fs = f(i);
end