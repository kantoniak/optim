1; % Make file executable

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