function [verbosity_level] = parse_display_option(options)
% -- [verbosity_level] = parse_display_option(options)
%
%     Parses value of 'Display' option into a numeric value.

    display = optimget(options, 'Display', 'notify');
    switch display
        case 'iter'
            verbosity_level = 3;
        case 'final'
            verbosity_level = 2;
        case 'notify'
            verbosity_level = 1;
        otherwise
            verbosity_level = 0;
    end
end
