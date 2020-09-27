% Reference wrapper class for holding struct array.
classdef iter_history < handle
    properties
        data
    end
    methods
        function obj = ref()
            obj.data = struct('state', 'iter', 'action', 'fcount', 'X', 'fval', 'f', 'f_diff', 'sgrad', 'sgrad_norm', 'sigma_plus', {});
        end
    end
end
