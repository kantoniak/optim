function [noisy_objective] = make_noisy_objective(smooth_objective)
% -- [noisy_objective] = make_noisy_objective(smooth_objective)
%
%     Creates noisy objective function from a smooth objective function. Noisy
%     function is clipped to [0, Inf].

    % Noise configuration
    rho = 1E-4;
    eta = 1E-4;

    noisy_objective = smooth_objective;
    noisy_objective.display_name = [smooth_objective.display_name ' (noisy)'];
    noisy_objective.func_name = ['noisy_' smooth_objective.func_name];
    noisy_objective.func = @(V) clip(add_noise(smooth_objective.func, V, rho, eta), 0, Inf);
    noisy_objective.pre_test_func = @() rand('state', random_seed);
end
