function iter_display_row(iter, fcount, fmin, procedure)
    fmin_str = pad_left(num2str(fmin, '%16.10f'), 17, ' ');
    printf("%9.0f    %10.0f    %s    %-15s\n", iter, fcount, fmin_str, procedure);
end
