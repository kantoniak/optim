% The function
function ret = nelders_favorite_func(x)
  ret = (x(1) - x(2)*x(3)*x(4))^2 + (x(2) - x(3)*x(4))^2 + (x(3) - x(4))^2 + x(4)^2;
end
