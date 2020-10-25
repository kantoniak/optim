function [result] = field_empty(options, name)
% -- field_empty(options, name)
%
%     Checks if structure field is empty.

    if ~isfield(options, name)  || isempty(options.(name))
        result = true;
    else
        result = false;
    end
end
