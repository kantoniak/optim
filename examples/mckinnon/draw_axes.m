% McKinnon initial simplex
function draw_axes()
  xline = @(xval, varargin) line([xval xval], ylim, varargin{:});
  yline = @(yval, varargin) line(xlim, [yval yval], varargin{:});

  xline(0, 'color', 'black');
  yline(0, 'color', 'black');
end
