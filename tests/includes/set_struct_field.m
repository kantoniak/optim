function [structure] = set_struct_field(structure, field_name, value)
% -- [structure] = set_struct_field(structure, field, value)
%
%     Sets the value of structure field.

    structure.(field_name) = value;
end
