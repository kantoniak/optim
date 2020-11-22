function mkdir_p(dir_path)
% -- mkdir_p(dir_path)
%
%     Creates directory if does not exist.

    if is_octave()
        mkdir(dir_path);
    elseif ~exist(dir_path, 'dir')
        mkdir(dir_path);
    end
end
