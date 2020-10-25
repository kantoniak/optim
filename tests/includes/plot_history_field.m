% Plots field value changes over iterations.
function plot_history_field(entries, field_name, plot_options)

    set_up_plot(plot_options);

    m = size(entries, 2);
    for i = 1:m
        if strcmp(entries(i).state, 'done')
            break;
        end

        data(i, 1) = entries(i).iter;
        data(i, 2) = entries(i).(field_name);

        if strcmp(entries(i).action, 'restart')
            restarts(i, 1) = entries(i).iter;
            restarts(i, 2) = entries(i).(field_name);
        end
    end

    hold on
        data_color = 0.3 * [1, 1, 1];
        semilogy(data(:, 1), data(:, 2), 'color', data_color);
        if exist('restarts', 'var')
            scatter(restarts(:, 1), restarts(:, 2), 16, 'd', 'markerfacecolor', data_color, 'filled');
        end
    hold off
end
