function [output_filename] = get_output_filename(output_dir, optimizer, func_name, n)
% -- [output_filename] = get_output_filename(output_dir, optimizer, func_name, n)
%
%     Generates filename for test data.

    output_filename = sprintf('%s%s-%s-%d.mat', output_dir, optimizer.func_name, func_name, n);
end
