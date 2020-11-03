function [max_fcount] = get_max_fcount(test_case)
% -- [max_fcount] = get_max_fcount(test_case)
%
%     Computes maximum function evaluations from data.

    max_fcount = 0;
    for i=1:size(test_case.dimensions(:), 1)
        n = test_case.dimensions(i);
        for j=1:size(test_case.optimizers, 2)

            % Load current count
            optimizer = test_case.optimizers(j);
            entries = load_test_data(get_output_filename(test_case.output_dir, optimizer, test_case.objective.func_name, n));
            final_entry = entries(end);

            if final_entry.fcount > max_fcount
                max_fcount = final_entry.fcount;
            end

        end
    end

end
