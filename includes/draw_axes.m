function draw_axes()
% -- draw_axes()
%
%     Draws vertical and horizontal axes passing through the origin. You can
%     pass arguments to `line()` through `varargin`.

  xline = @(xval, varargin) line([xval xval], ylim, varargin{:});
  yline = @(yval, varargin) line(xlim, [yval yval], varargin{:});

  xline(0, 'color', 'black');
  yline(0, 'color', 'black');
end
