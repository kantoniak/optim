% McKinnon initial simplex
function [X] = mckinnon_initial_simplex()
  lambda_plus = (1 + sqrt(33)) / 8;
  lambda_minus = (1 - sqrt(33)) / 8;
  X(:,1) = [1; 1];
  X(:,2) = [lambda_plus; lambda_minus];
  X(:,3) = [0; 0];
end
