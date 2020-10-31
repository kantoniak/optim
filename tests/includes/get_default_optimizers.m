function [optimizers] = get_default_optimizers()
% -- [optimizers] = get_default_optimizers()
%
%     Create default test optimizers.

    optimizers = struct('func', {});
    idx = 1;
    optimizers(idx).func = @fminsearch_nm;
    optimizers(idx).func_name = 'fminsearch_nm';
    optimizers(idx).display_name = 'fminsearch\_nm';
    optimizers(idx).line_style = '-';
    optimizers(idx).line_width = 0.5;

    idx = idx + 1;
    optimizers(idx).func = @fminsearch_nm;
    optimizers(idx).func_name = 'fminsearch_nm_restarts';
    optimizers(idx).display_name = 'fminsearch\_nm (with restarts)';
    optimizers(idx).line_style = '--';
    optimizers(idx).line_width = 0.5;

    % fminsearch_nm with greedy expansion
    idx = idx + 1;
    optimizers(idx).func = @fminsearch_nm;
    optimizers(idx).func_name = 'fminsearch_nm';
    optimizers(idx).display_name = 'fminsearch\_nm (greedy)';
    optimizers(idx).line_style = '-';
    optimizers(idx).line_width = 0.5;
    optimizers(idx).greedy_expansion = true;

    idx = idx + 1;
    optimizers(idx).func = @fminsearch;
    optimizers(idx).func_name = 'fminsearch';
    optimizers(idx).display_name = 'fminsearch';
    optimizers(idx).line_style = ':';
    optimizers(idx).line_width = 0.5;

    idx = idx + 1;
    optimizers(idx).func = @fminsearch_mds;
    optimizers(idx).func_name = 'fminsearch_mds';
    optimizers(idx).display_name = 'fminsearch\_mds';
    optimizers(idx).line_style = '-';
    optimizers(idx).line_width = 1.5;

    idx = idx + 1;
    optimizers(idx).func = @mdsmin;
    optimizers(idx).func_name = 'mdsmin';
    optimizers(idx).display_name = 'mdsmin';
    optimizers(idx).line_style = ':';
    optimizers(idx).line_width = 1.5;

end
