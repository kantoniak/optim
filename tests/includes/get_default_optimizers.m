function [optimizers] = get_default_optimizers()
% -- [optimizers] = get_default_optimizers()
%
%     Create default test optimizers.

    optimizers = struct('func', {});
    optimizers(1).func = @fminsearch;
    optimizers(1).func_name = 'fminsearch';
    optimizers(1).display_name = 'fminsearch';
    optimizers(1).line_style = ':';
    optimizers(1).line_width = 0.5;
    optimizers(2).func = @fminsearch_nm;
    optimizers(2).func_name = 'fminsearch_nm';
    optimizers(2).display_name = 'fminsearch\_nm';
    optimizers(2).line_style = '-';
    optimizers(2).line_width = 0.5;
    optimizers(3).func = @fminsearch_nm;
    optimizers(3).func_name = 'fminsearch_nm_restarts';
    optimizers(3).display_name = 'fminsearch\_nm (with restarts)';
    optimizers(3).line_style = '--';
    optimizers(3).line_width = 0.5;
    optimizers(4).func = @fminsearch_mds;
    optimizers(4).func_name = 'fminsearch_mds';
    optimizers(4).display_name = 'fminsearch\_mds';
    optimizers(4).line_style = ':';
    optimizers(4).line_width = 1.5;

end
