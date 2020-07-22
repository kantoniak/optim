% This presents samples of different simplex creation methods. All simplexes
% created from the same point.

x0 = [1, 1, 1];
X = create_simplex(2, x0);

plot_options = struct();
plot_options.title = 'Right-angled simplex';
plot_options.axes = [[1 2] [1 2] [1 2]];
plot_options.cam_position = [3, 4, 3.5];
plot_options.print_path = 'out/right_simplex.tex';
plot_options.print_size = [200, 200];

plot_R3_simplex(X, plot_options);
