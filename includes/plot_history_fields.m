% Plots multiple field value changes over iterations.
function plot_history_fields(entries, field_names, plot_dims, plot_options, print_options)
    field_count = size(field_names, 2);
    for idx = 1:field_count
        subplot(plot_dims(1), plot_dims(2), idx);
        set_up_plot(plot_options(idx));
        hold on
            plot_history_field(entries, char(field_names(idx)), []); % Empty field config
        hold off
    end

    print_plot(print_options);
end
