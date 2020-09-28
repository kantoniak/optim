% Prints plot to EPS if options are set.
function print_plot_to_epslatex(plot_options)

    if (~is_octave() || field_empty(plot_options, 'print_path'))
        return;
    end;

    print_size = strcat('-S', int2str(plot_options.print_size(1)), ',', int2str(plot_options.print_size(2)));
    print('-depslatex', '-mono', print_size, plot_options.print_path);
end
