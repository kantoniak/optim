function ret = mckinnon_func(x, tau, theta, phi)
% -- ret = mckinnon_func(x, tau, theta, phi)
%
%     Evaluates McKinnon example function, as defined in [1].
%
%   References:
%     [1] K. I. M. McKinnon, Convergence of the Nelder--Mead Simplex Method to
%         a Nonstationary Point, SIAM Journal on Optimization 9:1, 148–158.

  if x(1) > 0
    ret = (x(1) .^ tau) * theta + x(2) + (x(2) .^ 2);
  else
    ret = ((abs(x(1)) .^ tau) * theta * phi) + x(2) + (x(2) .^ 2);
  end
end
