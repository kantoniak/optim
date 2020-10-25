function plot_tests_history_field(tests, field_name, plot_options)
% -- plot_tests_history_field(tests, field_name, plot_options)
%
%     Read test data from multiple tests and plot a chart.

    set_up_plot(plot_options);

    hold on
        for i=1:size(tests.dimensions(:), 1)
            n = tests.dimensions(i);
            for j=1:size(tests.config, 2)
                config = tests.config(j);
                filename = get_output_filename(tests.output_dir, config.minimizer_func_name, tests.func_name, n);
                entries = load_test_data(filename);

                field_config = struct();
                field_config.display_name = config.display_name;
                field_config.line_style = config.line_style;
                field_config.line_width = config.line_width;
                plot_history_field(entries, field_name, field_config);
            end
        end

        legend();
    hold off

end
