% This presents samples of different simplex creation methods. All simplexes
% created from the same point.

x0 = [1, 1, 1];
X = create_simplex(0, x0);

plot_options = struct();
plot_options.title = 'L. Pfeffer method (zoomed in)';
plot_options.axes = [[1 1.075] [1 1.075] [1 1.075]];
plot_options.cam_position = [3, 4, 3.5];
plot_options.print_path = 'out/pfeffer_method.tex';
plot_options.print_size = [200, 200];

mkdir('out');
plot_R3_simplex(X, plot_options);
