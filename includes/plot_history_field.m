function plot_history_field(entries, field_name, field_config)
% -- plot_history_field(entries, field_name, field_config)
%
%     Plots field value changes over iterations.

    % Set defaults
    if isempty(field_config)
        field_config = get_default_field_config(field_name);
    end

    % Prepare data
    m = size(entries, 2);
    restart_num = 1;
    for i = 1:m
        if strcmp(entries(i).state, 'done')
            break;
        end

        plot_over_field = 'iter';
        if ~field_empty(field_config, 'plot_over')
            plot_over_field = field_config.plot_over;
        end

        data(i, 1) = entries(i).(plot_over_field);
        data(i, 2) = entries(i).(field_name);

        if strcmp(entries(i).action, 'restart')
            restart_entries(restart_num) = i;
            restarts(restart_num, 1) = entries(i).(plot_over_field);
            restarts(restart_num, 2) = entries(i).(field_name);
            restart_num = restart_num + 1;
        end
    end

    % Transform
    if ~field_empty(field_config, 'moving_average') && field_config.moving_average > 0
        samples = field_config.moving_average;

        if exist('restarts', 'var')
            % Do each restart separately and keep edge points
            prev_end = 0;
            for r=1:(restart_num-1)
                from = prev_end + 1;
                to = restart_entries(r) - 2;
                if (to - from < samples)
                    prev_end = restart_entries(r);
                    continue;
                end
                data(from:to, 2) = movmean(data(from:to, 2), samples);
                prev_end = restart_entries(r);
            end

            % Do last interval
            from = prev_end + 1;
            to = size(data, 1);
            if (to - from >= samples)
                data(from:to, 2) = movmean(data(from:to, 2), samples);
            end

        else
            data(:, 2) = movmean(data(:, 2), samples);
        end
    end

    data(:, 2) = abs(data(:, 2));

    % Draw
    data_color = 0.3 * [1, 1, 1];

    if ~field_empty(field_config, 'scatter') && field_config.scatter == true

        % Draw scatter points
        if is_octave()
            scatter(data(:, 1), data(:, 2), 2, 'd', 'markerfacecolor', data_color, 'filled');
        else
            scatter(data(:, 1), data(:, 2), 2, 'd', 'markerfacecolor', data_color);
        end

        if ~field_empty(field_config, 'polyfit') && field_config.polyfit >= 0

            % Interpolate and draw
            p = polyfit(data(:, 1), log(data(:, 2)), field_config.polyfit);
            polydata = exp(polyval(p, data(:, 1)));
            semilogy(data(:, 1), polydata, 'color', data_color, 'displayname', field_config.display_name, 'linestyle', field_config.line_style, 'linewidth', field_config.line_width, 'handlevisibility', 'off');
        end

    else
        semilogy(data(:, 1), data(:, 2), 'color', data_color, 'displayname', field_config.display_name, 'linestyle', field_config.line_style, 'linewidth', field_config.line_width);
    end

    if exist('restarts', 'var')
        restarts(:, 2) = abs(restarts(:, 2));
        if is_octave()
            scatter(restarts(:, 1), restarts(:, 2), 9, 'd', 'markerfacecolor', data_color, 'filled');
        else
            scatter(restarts(:, 1), restarts(:, 2), 9, 'd', 'markerfacecolor', data_color);
        end
    end
end
