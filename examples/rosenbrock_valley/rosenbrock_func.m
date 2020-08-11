% Extended Rosenbrock function
function ret = rosenbrock_func(x, a, b)
  ret = (a-x(1)).^2 + b*(x(2)-x(1).^2).^2;
end
