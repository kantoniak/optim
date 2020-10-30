function plot_test_cases_history_field(test_cases, field_name, plot_dims, plot_options, print_options)
% -- plot_test_cases_history_field(test_cases, field_name, plot_dims, plot_options, print_options)
%
%     Plot minimization of multiple test cases in subplots.

    case_count = size(test_cases, 2);
    for idx = 1:case_count
        test_case = test_cases(idx);

        subplot(plot_dims(1), plot_dims(2), idx);
        set_up_plot(plot_options(idx));
        hold on
            plot_test_case_history_field(test_case, field_name, plot_options(idx), []);
        hold off
    end

    print_plot_to_epslatex(print_options);
end
