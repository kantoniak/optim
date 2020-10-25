function [tests] = get_default_test_config()
% -- [tests] = get_default_test_config()
%
%     Create default test config.

    tests.config(1).minimizer_func = @fminsearch;
    tests.config(1).minimizer_func_name = 'fminsearch';
    tests.config(2).minimizer_func = @fminsearch_nm;
    tests.config(2).minimizer_func_name = 'fminsearch_nm';
    tests.config(3).minimizer_func = @fminsearch_nm;
    tests.config(3).minimizer_func_name = 'fminsearch_nm_restarts';
    tests.config(4).minimizer_func = @fminsearch_mds;
    tests.config(4).minimizer_func_name = 'fminsearch_mds';

end
