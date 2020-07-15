function [result] = field_empty(options, name)
    if ~isfield(options, name)  || isempty(options.(name))
        result = true;
    else
        result = false;
    end
end
