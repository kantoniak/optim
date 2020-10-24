function [data] = load_test_data(file_path)
% -- [data] = load_test_data(file_path)
%
%     Loads test data from file.

    data = load(file_path);
    data = data.iters;
end
