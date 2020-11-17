function ret = nelders_favorite_func(x)
% -- ret = nelders_favorite_func(x)
%
%     Evaluates Nelder's favorite function, as described in [1], Excercise
%     8.6.1.
%
%   References:
%     [1] Kelley, Carl T. Iterative methods for optimization. Society for
%         Industrial and Applied Mathematics, 1999.

  ret = (x(1) - x(2)*x(3)*x(4))^2 + (x(2) - x(3)*x(4))^2 + (x(3) - x(4))^2 + x(4)^2;
end
