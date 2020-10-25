function [tests] = get_default_test_config()
% -- [tests] = get_default_test_config()
%
%     Create default test config.

    tests.config(1).minimizer_func = @fminsearch;
    tests.config(1).minimizer_func_name = 'fminsearch';
    tests.config(1).display_name = 'fminsearch';
    tests.config(1).line_style = '-';
    tests.config(1).line_width = 0.5;
    tests.config(2).minimizer_func = @fminsearch_nm;
    tests.config(2).minimizer_func_name = 'fminsearch_nm';
    tests.config(2).display_name = 'fminsearch\_nm';
    tests.config(2).line_style = '--';
    tests.config(2).line_width = 0.5;
    tests.config(3).minimizer_func = @fminsearch_nm;
    tests.config(3).minimizer_func_name = 'fminsearch_nm_restarts';
    tests.config(3).display_name = 'fminsearch\_nm (with restarts)';
    tests.config(3).line_style = ':';
    tests.config(3).line_width = 0.5;
    tests.config(4).minimizer_func = @fminsearch_mds;
    tests.config(4).minimizer_func_name = 'fminsearch_mds';
    tests.config(4).display_name = 'fminsearch\_mds';
    tests.config(4).line_style = '-';
    tests.config(4).line_width = 1.5;

end
