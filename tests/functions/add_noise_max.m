function [value] = add_noise_max(f, V, rho, eta)
% -- [value] = add_noise_max(f, V, rho, eta)
%
%     Add noise to value of function `f` using formula
%
%       f(V) + max(rho*abs(f(V)), eta) * mu
%
%     where `mu` is a random number generated with uniform distribution from
%     range [-1, 1]. Use `rand('state', seed)` to set Mersenne Twister seed.

    mu = unifrnd(-1, 1);
    value = f(V);
    value = value + min(rho*abs(value), eta) * mu;

end
