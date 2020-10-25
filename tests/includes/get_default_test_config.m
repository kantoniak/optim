function [config] = get_default_test_config()
% -- [config] = get_default_test_config()
%
%     Create default test config.

    config = struct('minimizer_func', {});
    config(1).minimizer_func = @fminsearch;
    config(1).minimizer_func_name = 'fminsearch';
    config(1).display_name = 'fminsearch';
    config(1).line_style = '-';
    config(1).line_width = 0.5;
    config(2).minimizer_func = @fminsearch_nm;
    config(2).minimizer_func_name = 'fminsearch_nm';
    config(2).display_name = 'fminsearch\_nm';
    config(2).line_style = '--';
    config(2).line_width = 0.5;
    config(3).minimizer_func = @fminsearch_nm;
    config(3).minimizer_func_name = 'fminsearch_nm_restarts';
    config(3).display_name = 'fminsearch\_nm (with restarts)';
    config(3).line_style = ':';
    config(3).line_width = 0.5;
    config(4).minimizer_func = @fminsearch_mds;
    config(4).minimizer_func_name = 'fminsearch_mds';
    config(4).display_name = 'fminsearch\_mds';
    config(4).line_style = '-';
    config(4).line_width = 1.5;

end
