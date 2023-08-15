function vectorfield(F, G, H, range, gridDensity)
    % Vector plane field visualization
    
    % Define the x, y and z grids.
    x = linspace(0, range, gridDensity);
    y = linspace(0, range, gridDensity);
    z = linspace(0, 1, gridDensity);
    [X, Y, Z] = meshgrid(x, y, z);
    
    % Calculate the vector field.
    U = F(X, Y, Z);
    V = G(X, Y, Z);
    W = H(X, Y, Z);
    
    % Plot the vector field.
    quiver3(X, Y, Z, U, V, W,'linewidth',1.5,'color','b');
    axis([-0 range -0 range 0 1]);

    % Set axis ticks and labels
    xlabel('$x$', 'interpreter', 'latex', 'fontsize', 28);
    ylabel('$y$', 'interpreter', 'latex', 'fontsize', 28);
    zlabel('$z$', 'interpreter', 'latex', 'fontsize', 28);
end
