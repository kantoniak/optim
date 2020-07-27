function o = xoptimset(varargin)
% -- o = xoptimset('param1', value1, 'param2', value2, ...)
%
%     Set value of option from options defined by `optimset`. This function
%     extends `optimset` implementation with custom options:
%
%         "InitialSimplexStrategy": strategy of creating initial simplex from
%         the initial point. For possible strategies, see documentation of
%         `create_simplex`.
%
%         "InitialSimplex": if set, it overrides the default initial simplex
%         vertices with matrix set as option.
%
%         "HaltingTest": halting test used to stop iterations. For available
%         tests, see documentation of `should_halt`.
%
%     For description of other options, see documentation for 'optimset'.

    orig_names = {                                                             ...
        'Display'; 'MaxFunEvals'; 'MaxIter'; 'TolFun'; 'TolX'; 'FunValCheck';  ...
        'OutputFcn'; 'PlotFcns'                                                ...
    };

    custom_names = {                                                           ...
        'InitialSimplexStrategy'; 'InitialSimplex'; 'HaltingTest'              ...
    };

    argc = nargin;
    if rem(argc, 2) == 1
        error('Not all fields have values');
    end

    % Set custom options aside
    optimset_args = {};
    optimset_size = 0;
    custom_args = {};
    custom_size = 0;
    for i = 1:2:argc
        name = varargin{i};
        value = varargin{i+1};
        if sum(strcmpi(custom_names, name)) == 1
            custom_size = custom_size + 1;
            custom_args{1, custom_size} = name;
            custom_size = custom_size + 1;
            custom_args{1, custom_size} = value;
        else
            optimset_size = optimset_size + 1;
            optimset_args{1, optimset_size} = name;
            optimset_size = optimset_size + 1;
            optimset_args{1, optimset_size} = value;
        end
    end

    % Call optimset
    o = optimset(optimset_args{:});

    % Set custom options
    for i = 1:2:custom_size
        name = custom_args{1, i};
        value = custom_args{1, i+1};
        o.(name) = value;
    end
end
