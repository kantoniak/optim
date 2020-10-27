function plot_test_case_history_field(test_case, field_name, plot_options)
% -- plot_test_case_history_field(test_case, field_name, plot_options)
%
%     Read test data from multiple test_case and plot a chart.

    set_up_plot(plot_options);

    hold on
        for i=1:size(test_case.dimensions(:), 1)
            n = test_case.dimensions(i);
            for j=1:size(test_case.config, 2)
                config = test_case.config(j);
                filename = get_output_filename(test_case.output_dir, config.minimizer_func_name, test_case.func_name, n);
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
