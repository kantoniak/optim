function [config] = get_default_field_config(field_name)
% -- [config] = get_default_field_config(field_name)
%
%     Create default plot field config.

    config = struct();
    config.display_name = field_name;
    config.line_style = '-';
    config.line_width = 0.5;

end
