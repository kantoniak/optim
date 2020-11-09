function [structure] = set_struct_field(structure, field_name, value)
% -- [structure] = set_struct_field(structure, field, value)

    structure.(field_name) = value;
end
