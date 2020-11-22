function plot_test_case_history_field(test_case, field_name, plot_options, print_options)
% -- plot_test_case_history_field(test_case, field_name, plot_options, print_options)
%
%     Read test data from multiple test_case and plot a chart.

    set_up_plot(plot_options);

    hold on
        % Plot values
        for i=1:size(test_case.dimensions(:), 1)
            n = test_case.dimensions(i);
            for j=1:size(test_case.optimizers, 2)
                optimizer = test_case.optimizers(j);
                for k=1:size(test_case.objective, 2)
                    objective = test_case.objective(k);

                    filename = get_output_filename(test_case.output_dir, optimizer, objective.func_name, n);
                    entries = load_test_data(filename);

                    field_config = struct();
                    field_config.display_name = optimizer.display_name;
                    field_config.line_style = optimizer.line_style;
                    field_config.line_width = optimizer.line_width;

                    if ~field_empty(optimizer, 'scatter')
                        field_config.scatter = optimizer.scatter;
                    end

                    if ~field_empty(optimizer, 'polyfit')
                        field_config.polyfit = optimizer.polyfit;
                    end

                    if ~field_empty(optimizer, 'moving_average')
                        field_config.moving_average = optimizer.moving_average;
                    end

                    if ~field_empty(plot_options, 'plot_over')
                        field_config.plot_over = plot_options.plot_over;
                    end

                    % Pre-test function
                    if ~field_empty(objective, 'pre_plot_func')
                        field_config = objective.pre_plot_func(field_config);
                    end

                    plot_history_field(entries, field_name, field_config);
                end
            end
        end

        % Show legend
        if ~field_empty(plot_options, 'show_legend') && plot_options.show_legend == true

            % Get labels
            labels = {};
            for j=1:size(test_case.optimizers, 2)
                optimizer = test_case.optimizers(j);
                labels{end + 1} = optimizer.display_name;
            end

            % Set location
            if ~field_empty(plot_options, 'legend_location')
                legend_location = plot_options.legend_location;
            else
                legend_location = 'northeast';
            end

            legend_obj = legend(labels);
            set(legend_obj, 'color', 'none');
            set(legend_obj, 'location', legend_location);
            legend('boxoff');

        end
    hold off

    print_plot(print_options);

end
