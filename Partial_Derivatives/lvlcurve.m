function lvlcurve(f, gridType)
    % Determine the type of grid to use
    if strcmp(gridType, 'pol')
        % Create a grid of points in polar coordinates
        [Theta, R] = meshgrid(linspace(0, 2*pi, 41), linspace(0, sqrt(3), 41));

        % Convert polar coordinates to Cartesian coordinates
        X = R.*cos(Theta);
        Y = R.*sin(Theta);
    elseif strcmp(gridType, 'cart')
        % Create a grid of points in Cartesian coordinates
        [X, Y] = meshgrid(linspace(-3, 3, 41));
    else
        error('gridType must be "cart" or "pol"')
    end

    % Calculate the Z coordinates for the function
    Z = f(X, Y);
    
    % Plot the function
    figure;
    subplot(1, 2, 1);
    surf(X, Y, Z);
    hold on;
    
    % Set axis ticks and labels
    xlabel('$x$', 'interpreter', 'latex', 'fontsize', 28);
    ylabel('$y$', 'interpreter', 'latex', 'fontsize', 28);
    zlabel('$z$', 'interpreter', 'latex', 'fontsize', 28);
    title('$f(x,y)=-\frac{3y}{x^2+y^2+1}$', 'interpreter', 'latex', 'fontsize', 28);
    
    % Plot level curves
    subplot(1, 2, 2);
    contour(X, Y, Z, 20);
    axis equal;
    hold on;
    
    % Set axis ticks and labels for contour plot
    xlabel('$x$', 'interpreter', 'latex', 'fontsize', 28);
    ylabel('$y$', 'interpreter', 'latex', 'fontsize', 28);
    title('Level curves $f(x,y)=k$', 'interpreter', 'latex', 'fontsize', 28);

end

% Plane
% f = @(x,y) 4-2*x-y;

% Hemisphere
% f = @(x,y) sqrt(3-x.^2-y.^2)

% Elliptic Paraboloid 1
% f = @(x,y) 2*x.^2+y.^2+1;

% Elliptic Paraboloid 2
% f = @(x,y) x.^2+2*y.^2+1;

% 4 hills
% f = @(x,y) -x.*y.*exp(-x.^2-y.^2);

% dipoles
% f = @(x,y) -3*y./(x.^2+y.^2+1);