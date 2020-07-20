function [norm_inf] = simplex_max_norm_inf(S)
% -- [norm_inf] = simplex_max_norm_inf(S)
%
%     Compute max oriented length of a simplex S. Simplex points are
%     represented as matrix columns.
    N = size(S, 1);
    V = S(:, 2:N+1) - S(:, ones(1,N));
    norm_inf = max(max(abs(V)));
end
