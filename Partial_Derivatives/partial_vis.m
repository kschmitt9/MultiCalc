function partial_vis(f_sym, a, b, t, rng)

    syms x y;

    % Compute the derivatives
    dfdx = diff(f_sym, x);
    dfdy = diff(f_sym, y);

    % Define the x and y domain
    [x_vals_mesh, y_vals_mesh] = meshgrid(t, t);

    % Compute z values
    f = matlabFunction(f_sym);
    z_vals = f(x_vals_mesh, y_vals_mesh);

    % Compute the z min and max
    z_min = min(z_vals(:));
    z_max = max(z_vals(:));

    % Compute z0 at point (a, b)
    z0 = f(a, b);

    % Compute tangent lines at (a, b)
    dfdx_fun = matlabFunction(dfdx, 'Vars', [x, y]);
    dfdy_fun = matlabFunction(dfdy, 'Vars', [x, y]);
    tangent_line_x = dfdx_fun(a, b).*(t - a) + z0;
    tangent_line_y = dfdy_fun(a, b).*(t - b) + z0;

    % Compute cross-sections at (a, b)
    cross_section_x = arrayfun(@(y) f(a, y), t);
    cross_section_y = arrayfun(@(x) f(x, b), t);

    % Create the 3D surface plot
    surf(x_vals_mesh, y_vals_mesh, z_vals);
    caxis([z_min z_max]);
    shading interp;
    colormap(summer);
    hold on;
    d1 = plot3(t, b*ones(size(t)), tangent_line_x, 'r', 'LineWidth', 2);
    d2 = plot3(a*ones(size(t)), t, tangent_line_y, 'b', 'LineWidth', 2);

    % Create cross-section lines
    h1 = plot3(a*ones(size(t)), t, cross_section_x, 'LineWidth', 2, 'color', [87/255,181/255,254/255]);
    h2 = plot3(t, b*ones(size(t)), cross_section_y, 'LineWidth', 2, 'color', [1,100/255,0]);

    % Set the z-axis limits
    zlim([z_min + rng(1), z_max + rng(2)]);
    xlabel('x-axis');
    ylabel('y-axis');
    zlabel('z-axis');
    legend([d1,d2,h1,h2],'f_x Tangent', 'f_y Tangent', 'x Cross-section', 'y Cross-section','location','best');

    hold off;
    grid on;

end
