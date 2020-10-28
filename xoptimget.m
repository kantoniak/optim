function o = xoptimget(options, name, default)
% -- o = xoptimget(options, name, default)
%
%     Get value of option from options defined by `xoptimset`. This function
%     extends `optimset` implementation with custom options. For list of
%     options, see documentation for 'xoptimset'.

    names = {                                                                  ...
        'Display'; 'MaxFunEvals'; 'MaxIter'; 'TolFun'; 'TolX'; 'FunValCheck';  ...
        'OutputFcn'; 'PlotFcns'; 'InitialSimplexStrategy'; 'InitialSimplex';   ...
        'HaltingTest'; 'MaxOrientedRestarts'; 'AcceptWeakExpansion'            ...
    };

    matches = strcmpi(names, name);
    matched = sum(matches);

    if matched == 0
        warning ('xoptimget: unrecognized option: %s', name);
        o = default;
    else if isfield(options, name) && ~isempty(options.(name))
        o = options.(name);
    else
        o = default;
    end
end
