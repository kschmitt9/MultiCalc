function tangentplane(f_sym, a, b, t, rng)
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
    
    % Compute tangent plane
    dfdx_fun = matlabFunction(dfdx, 'Vars', [x, y]);
    dfdy_fun = matlabFunction(dfdy, 'Vars', [x, y]);
    tangent_plane = dfdx_fun(a, b).*(x_vals_mesh - a) + dfdy_fun(a, b).*(y_vals_mesh - b) + z0;
    
    % Create the 3D surface plot
    surf(x_vals_mesh, y_vals_mesh, z_vals);
    caxis([z_min z_max]);
    shading interp;
    colormap(summer);
    hold on;
    
    % Plot the tangent plane
    surf(x_vals_mesh, y_vals_mesh, tangent_plane, 'FaceColor', 'r', 'FaceAlpha', 0.5,'edgecolor','none');
    
    % Adjusting plot attributes
    zlim([z_min + rng(1), z_max + rng(2)]);
    xlabel('x-axis');
    ylabel('y-axis');
    zlabel('z-axis');
    legend('Surface', 'Tangent Plane');
    
    hold off;
    grid on;
    view(3); % 3D view
    
end
