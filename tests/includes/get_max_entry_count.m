function [max_entry_count] = get_max_entry_count(tests)
% -- [count] = get_max_entry_count(tests)
%
%     Computes maximum iteration number from data.

    max_entry_count = 0;
    for i=1:size(tests.dimensions(:), 1)
        n = tests.dimensions(i);
        for j=1:size(tests.config, 2)

            % Load current count
            config = tests.config(j);
            entries = load_test_data(get_output_filename(tests.output_dir, config.minimizer_func_name, tests.func_name, n));
            entry_count = size(entries, 2);

            if entry_count > max_entry_count
                max_entry_count = entry_count;
            end

        end
    end

end
