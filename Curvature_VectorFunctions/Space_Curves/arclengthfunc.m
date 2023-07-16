function arclengthfunc(x_func, y_func, z_func, t1, t2)
    % Create parameter range
    t = linspace(0, 2*pi, 400);

    % Calculate the coordinates of the space curve
    x = x_func(t);
    y = y_func(t);
    z = z_func(t);

    % Calculate the position vectors
    x1 = x_func(t1);
    y1 = y_func(t1);
    z1 = z_func(t1);

    x2 = x_func(t2);
    y2 = y_func(t2);
    z2 = z_func(t2);

    % Plot the space curve
    figure;
    plot3(x, y, z, 'LineWidth', 2);
    hold on;

    % Plot the position vectors
    quiver3(0, 0, 0, x1, y1, z1, 'r', 'LineWidth', 2);
    quiver3(0, 0, 0, x2, y2, z2, 'g', 'LineWidth', 2);

    xlabel('x');
    ylabel('y');
    zlabel('z');
    grid on;
    title('Arc length');
    legend('Space Curve', 'Initial Vector', 'Terminal Vector');
    axis equal;
end

% Helix z-axis
% f=@(z)exp(z).*sin(z);g=@(z)exp(z).*cos(z);h=@(z)sqrt(2)*exp(z);