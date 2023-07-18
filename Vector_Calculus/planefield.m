function planefield(F, G, range, gridDensity)
    % Vector plane field visualization
    
    % Define the x, y and z grids.
    x = linspace(-range, range, gridDensity);
    y = linspace(-range, range, gridDensity);
    [X, Y] = meshgrid(x, y);
    
    % Calculate the vector field.
    U = F(X, Y);
    V = G(X, Y);
    
    % Plot the vector field.
    quiver3(X, Y, U, V);
    axis([-range range -range range]);
end
