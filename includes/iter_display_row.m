function iter_display_row(iter, fcount, fmin, procedure)
% -- iter_display_row(iter, fcount, fmin, procedure)
%
%     Displays row of iteration details.

    fmin_str = pad_left(num2str(fmin, '%16.10f'), 17, ' ');
    fprintf('%9.0f    %10.0f    %s    %-15s\n', iter, fcount, fmin_str, procedure);
end
