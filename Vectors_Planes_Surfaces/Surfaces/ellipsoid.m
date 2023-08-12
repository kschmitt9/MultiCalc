function ellipsoid(a, b, c)
    % Define the angular range for the ellipsoid
    theta = linspace(0, 2*pi, 101);
    phi = linspace(0, pi, 101);
    
    % Calculate the coordinates of the ellipsoid
    X = a * sin(phi') * cos(theta);
    Y = b * sin(phi') * sin(theta);
    Z = c * cos(phi') * ones(1, 101);
    
    % Plot the ellipsoid
    figure;
    surf(X, Y, Z);
    shading interp;
    colormap(summer);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    hold on;
    
    % Set the axis properties
    axis equal;
    title('Ellipsoid');
end

% Example
% a = 2;
% b = 3;
% c = 1;
% ellipsoid(a, b, c);
