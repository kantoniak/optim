function ret_val = suppress_warnings(fun)
    % Save warning settings
    w = warning();
    warning('off');
    ret_val = fun();
    warning(w);
end
