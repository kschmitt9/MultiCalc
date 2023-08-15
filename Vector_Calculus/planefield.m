function planefield(F, G, range, gridDensity)
    % Vector plane field visualization
    
    % Define the x and y grids.
    x = linspace(0, range, gridDensity);
    y = linspace(0, 2, gridDensity);
    [X, Y] = meshgrid(x, y);
    
    % Calculate the vector field.
    U = F(X, Y);
    V = G(X, Y);
    
    % Plot the vector field.
    quiver(X, Y, U, V,'color','b','linewidth',1.5);
    axis([0 range 0 2]);

    % Set axis ticks and labels
    xlabel('$x$', 'interpreter', 'latex', 'fontsize', 28);
    ylabel('$y$', 'interpreter', 'latex', 'fontsize', 28);
end
