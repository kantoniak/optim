function iter_display_header()
% -- iter_display_header()
%
%     Displays header of iteration details table.

    minfx_str = pad_left('min f(x)', 17, ' ');
    fprintf('Iteration    Func-count    %s    Procedure\n', minfx_str);
end
