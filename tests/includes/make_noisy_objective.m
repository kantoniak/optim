function [noisy_objective] = make_noisy_objective(smooth_objective, noise_type)
% -- [noisy_objective] = make_noisy_objective(smooth_objective, noise_type)
%
%     Creates noisy objective function from a smooth objective function. Noise
%     type is either 'min' or 'max'.

    % Noise configuration
    rho = 1E-3;
    eta = 1E-3;
    random_seed = 100;

    noisy_objective = smooth_objective;
    noisy_objective.pre_test_func = @() rand('state', random_seed);

    type_equals = @(str) (strcmpi(noise_type, str) == true);
    switch true

        case type_equals('max')
            noisy_objective.display_name = [smooth_objective.display_name ' (noisy - max)'];
            noisy_objective.func_name = ['noisymax_' smooth_objective.func_name];
            noisy_objective.func = @(V) add_noise_max(smooth_objective.func, V, rho, eta);

        case type_equals('min')
            noisy_objective.display_name = [smooth_objective.display_name ' (noisy - min)'];
            noisy_objective.func_name = ['noisymin_' smooth_objective.func_name];
            noisy_objective.func = @(V) add_noise_min(smooth_objective.func, V, rho, eta);

        otherwise
            error('xoptim:unknownNoiseType', 'Error.\nUnknown noise type %s', noise_type);
    end
end
