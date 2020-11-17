function [X] = mckinnon_initial_simplex()
% -- [X] = mckinnon_initial_simplex()
%
%     Computes McKinnon initial simplex, as defined in [1]. Simplex vertices
%     asre returned as columns of `X`.
%
%   References:
%     [1] K. I. M. McKinnon, Convergence of the Nelder--Mead Simplex Method to
%         a Nonstationary Point, SIAM Journal on Optimization 9:1, 148–158.

  lambda_plus = (1 + sqrt(33)) / 8;
  lambda_minus = (1 - sqrt(33)) / 8;
  X(:,1) = [1; 1];
  X(:,2) = [lambda_plus; lambda_minus];
  X(:,3) = [0; 0];
end
