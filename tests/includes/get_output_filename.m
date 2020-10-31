function [output_filename] = get_output_filename(output_dir, optimizer, func_name, n)
% -- [output_filename] = get_output_filename(output_dir, optimizer, func_name, n)
%
%     Generates filename for test data.

    optimizer_name = optimizer.func_name;

    if ~field_empty(optimizer, 'weak_expansion') && optimizer.weak_expansion == false
        optimizer_name = sprintf('%s_%s', optimizer_name, 'strict');
    end

    output_filename = sprintf('%s%s-%s-%d.mat', output_dir, optimizer_name, func_name, n);
end
