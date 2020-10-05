% This generates lattice of points from MDS simplexes as presented in [1].
%
% References:
%   [1] Virginia Torczon, On the convergence of pattern search algorithms,
%       SIAM Journal on Optimization 7:1, 1-25.

X = [-3 1 2; -2 5 -1];
subplot_dims = [2 2];
discard_test = @(X) (~triangle_in_rect(X, [plot_options.x_range plot_options.y_range]) || simplex_diameter(X) < 4);
plot_func = @(X) plot_simplex(X, discard_test);
initial_triangle_thickness = 1;

plot_options = struct();
plot_options.x_range = [-1, 1] * 20;
plot_options.y_range = [-1, 1] * 20;
plot_options.aspect = [1, 1];
plot_options.x_ticks = 9;
plot_options.y_ticks = 9;
plot_options.grid = true;
plot_options.pre_draw_func = @() draw_axes();

% Single move
subplot(subplot_dims(1), subplot_dims(2), 1);
plot_options.title = 'Single move';
set_up_plot(plot_options);

hold on
    simulate_moves(X, 1, plot_func);
    plot_simplex(X, @() false, false, [0, 0, 0], initial_triangle_thickness);
hold off

% Two moves
subplot(subplot_dims(1), subplot_dims(2), 2);
plot_options.title = 'Two moves';
set_up_plot(plot_options);

hold on
    simulate_moves(X, 2, plot_func);
    plot_simplex(X, @() false, false, [0, 0, 0], initial_triangle_thickness);
hold off

% Three moves
subplot(subplot_dims(1), subplot_dims(2), 3);
plot_options.title = 'Three moves';
set_up_plot(plot_options);

hold on
    simulate_moves(X, 3, plot_func);
    plot_simplex(X, @() false, false, [0, 0, 0], initial_triangle_thickness);
hold off

% Generated points
subplot(subplot_dims(1), subplot_dims(2), 4);
plot_options.title = 'Generated points';
set_up_plot(plot_options);

hold on
    plot_func = @(X) plot_simplex(X, discard_test, true);
    simulate_moves(X, 3, plot_func);
hold off

% Output graphs
print_options = struct();
print_options.print_path = 'out/mds_grid.tex';
print_options.print_size = [400, 360];
print_plot_to_epslatex(print_options);
