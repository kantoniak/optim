% McKinnon initial simplex
function [X] = nelders_favorite_initial_simplex(v_diag)
  X = [ones(4, 1) * 10, diag(v_diag)];
end
