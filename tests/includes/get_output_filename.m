function [output_filename] = get_output_filename(output_dir, optimizer, func_name, n)
% -- [output_filename] = get_output_filename(output_dir, optimizer, func_name, n)
%
%     Generates filename for test data.

    optimizer_name = optimizer.func_name;

    if ~field_empty(optimizer, 'greedy_expansion') && optimizer.greedy_expansion == true
        optimizer_name = sprintf('%s_%s', optimizer_name, 'greedy');
    end

    output_filename = sprintf('%s%s-%s-%d.mat', output_dir, optimizer_name, func_name, n);
end
