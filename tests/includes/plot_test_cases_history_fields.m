function plot_test_cases_history_fields(test_cases, field_names, plot_dims, plot_options, print_options)
% -- plot_test_cases_history_field(test_cases, field_names, plot_dims, plot_options, print_options)
%
%     Plot minimization of multiple test cases in subplots.

    clf();

    case_count = size(test_cases, 2);

    cell_names = false;
    if iscell(field_names)
        field_count = size(field_names, 2);
        cell_names = true;
    else
        field_count = 1;
    end

    for idx = 1:case_count
        test_case = test_cases(idx);

        for f_idx = 1:field_count
            if cell_names
                field_name = char(field_names(f_idx));
            else
                field_name = field_names;
            end

            plot_idx = field_count * (idx - 1) + f_idx;
            subplot(plot_dims(1), plot_dims(2), plot_idx);
            set_up_plot(plot_options(plot_idx));
            hold on
                plot_test_case_history_field(test_case, field_name, plot_options(plot_idx), []);
            hold off
        end
    end

    print_plot(print_options);
end
