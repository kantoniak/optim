function [data] = load_test_data(file_path)
% -- [data] = load_test_data(file_path)
%
%     Loads test data from file.

    data = load_variable(file_path, 'iters');
end
