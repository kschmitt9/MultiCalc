function vectorfield(F, G, H, range, gridDensity)
    % Vector field visualization
    
    % Define the x, y and z grids.
    x = linspace(-range, range, gridDensity);
    y = linspace(-range, range, gridDensity);
    z = linspace(-range, range, gridDensity);
    [X, Y, Z] = meshgrid(x, y, z);
    
    % Calculate the vector field.
    U = F(X, Y, Z);
    V = G(X, Y, Z);
    W = H(X, Y, Z);
    
    % Plot the vector field.
    quiver3(X, Y, Z, U, V, W);
    axis([-range range -range range -range range]);
end
