function [Xs, X_prevs, fs, f_prevs] = sort_by_values(X, X_prev, f, f_prev)
% -- [Xs, X_prevs, fs, f_prevs] = sort_by_values(X, X_prev, f, f_prev)
%
%     Sorts `f` ascending and applies the same permutation to columns of `X`,
%     `X_prev` and `f_prev`.
%
%     If `f_prev` is empty, then `f_prevs` is equal to `fs`.

    [~, i] = sort(f);          % I holds sorting order
    Xs = X(:,i);               % apply this order to vector
    X_prevs = X_prev(:,i);     % apply this order to vector
    fs = f(i);
    if ~isempty(f_prev)
        f_prevs = f_prev(i);
    else
        f_prevs = fs;
    end
end
