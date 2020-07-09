function [sigma_plus] = simplex_max_oriented_length(S)
% -- [sigma_plus] = simplex_max_oriented_length(S)
%
%     Compute max oriented length of a simplex S. Simplex points are
%     represented as matrix columns.
    N = size(S, 1);
    V = S(:, 2:N+1) - S(:, ones(1,N));
    sigma_plus = max(max(abs(V)));
end
