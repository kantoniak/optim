function print_plot(print_options)
% -- print_plot(print_options)
%
%     Prints plot to file if options are set. If `path` is not set, function
%     will skip printing.

    if (~is_octave() || field_empty(print_options, 'print_path'))
        return;
    end

    % Get format
    [directory, basename, extension] = fileparts(print_options.print_path);

    ext_equals = @(str) (strcmpi(extension, str) == true);
    switch true

        case ext_equals('.tex')
            print_format = '-depslatex';

        case ext_equals('.png')
            print_format = '-dpng';

        otherwise
            error('xoptim:unsupportedExtension', 'Error.\nExtension %s not supported', extension);
    end

    % Get size
    print_size = strcat('-S', int2str(print_options.print_size(1)), ',', int2str(print_options.print_size(2)));

    print(print_format, '-mono', print_size, print_options.print_path);
end
