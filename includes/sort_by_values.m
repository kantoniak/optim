% Sort `f` and apply the same permutation to columns of `X` and `X_prev`
function [Xs, X_prevs, fs] = sort_by_values(X, X_prev, f)
    [~, i] = sort(f);          % I holds sorting order
    Xs = X(:,i);               % apply this order to vector
    X_prevs = X_prev(:,i);     % apply this order to vector
    fs = f(i);
end
