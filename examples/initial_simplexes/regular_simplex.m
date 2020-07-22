% This presents samples of different simplex creation methods. All simplexes
% created from the same point.

x0 = [1, 2, 3];
X = create_simplex(1, x0);

plot_options = struct();
plot_options.title = 'Regular simplex';
plot_options.x_range = [1 4];
plot_options.y_range = [2 5];
plot_options.z_range = [3 6];
plot_options.x_ticks = 4;
plot_options.y_ticks = 4;
plot_options.z_ticks = 4;
plot_options.cam_position = [3, 5, 5.5];
plot_options.print_path = 'out/regular_simplex.tex';
plot_options.print_size = [200, 200];

plot_R3_simplex(X, plot_options);
