function [max_entry_count] = get_max_entry_count(test_case)
% -- [count] = get_max_entry_count(test_case)
%
%     Computes maximum iteration number from data.

    max_entry_count = 0;
    for i=1:size(test_case.dimensions(:), 1)
        n = test_case.dimensions(i);
        for j=1:size(test_case.config, 2)

            % Load current count
            config = test_case.config(j);
            entries = load_test_data(get_output_filename(test_case.output_dir, config.minimizer_func_name, test_case.func_name, n));
            entry_count = size(entries, 2);

            if entry_count > max_entry_count
                max_entry_count = entry_count;
            end

        end
    end

end
