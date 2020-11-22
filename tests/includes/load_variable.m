function [data] = load_variable(file_path, var_name)
% -- [data] = load_test_data(file_path, var_name)
%
%     Loads variable from file.

    data = load(file_path);
    data = data.(var_name);
end
