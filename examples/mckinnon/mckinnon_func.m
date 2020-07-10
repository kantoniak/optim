% McKinnon example function
function ret = mckinnon_func(x, tau, theta, phi)
  if x(1) > 0
    ret = (x(1) .^ tau) * theta + x(2) + (x(2) .^ 2);
  else
    ret = ((abs(x(1)) .^ tau) * theta * phi) + x(2) + (x(2) .^ 2);
  end
end
