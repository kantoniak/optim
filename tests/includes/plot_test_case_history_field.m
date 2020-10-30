function plot_test_case_history_field(test_case, field_name, plot_options)
% -- plot_test_case_history_field(test_case, field_name, plot_options)
%
%     Read test data from multiple test_case and plot a chart.

    set_up_plot(plot_options);

    hold on
        % Plot values
        for i=1:size(test_case.dimensions(:), 1)
            n = test_case.dimensions(i);
            for j=1:size(test_case.optimizers, 2)
                optimizer = test_case.optimizers(j);
                filename = get_output_filename(test_case.output_dir, optimizer.func_name, test_case.objective.func_name, n);
                entries = load_test_data(filename);

                field_config = struct();
                field_config.display_name = optimizer.display_name;
                field_config.line_style = optimizer.line_style;
                field_config.line_width = optimizer.line_width;
                plot_history_field(entries, field_name, field_config);
            end
        end

        % Show legend
        if ~field_empty(plot_options, 'show_legend')

            % Get labels
            labels = {};
            for j=1:size(test_case.optimizers, 2)
                optimizer = test_case.optimizers(j);
                labels{end + 1} = optimizer.display_name;
            end

            legend(labels, 'location', 'northeast');
            legend('boxoff');

        end
    hold off

end
