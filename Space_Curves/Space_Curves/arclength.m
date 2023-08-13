function arclength(x_func, y_func, z_func, t1, t2)
    % Create parameter range
    t = linspace(0, 2*pi, 400);

    % Calculate the coordinates of the entire space curve
    x = x_func(t);
    y = y_func(t);
    z = z_func(t);

    % Get the segment between t1 and t2
    segment_t = linspace(t1, t2, 100);
    x_segment = x_func(segment_t);
    y_segment = y_func(segment_t);
    z_segment = z_func(segment_t);

    % Calculate the position vectors
    x1 = x_func(t1);
    y1 = y_func(t1);
    z1 = z_func(t1);

    x2 = x_func(t2);
    y2 = y_func(t2);
    z2 = z_func(t2);

    % Plot the space curve
    figure;
    plot3(x, y, z, 'b', 'LineWidth', 1); % Reduced line width for visibility
    hold on;
    
    % Plot the segment between t1 and t2 in a different color (e.g., magenta)
    plot3(x_segment, y_segment, z_segment, 'm', 'LineWidth', 2);

    % Plot the position vectors
    quiver3(0, 0, 0, x1, y1, z1, 'r', 'LineWidth', 2,'autoscale','off');
    quiver3(0, 0, 0, x2, y2, z2, 'g', 'LineWidth', 2,'autoscale','off');

    xlabel('x');
    ylabel('y');
    zlabel('z');
    grid on;
    legend('Space Curve', 'Arc Segment', 'Initial Vector', 'Terminal Vector','location','best');
    axis equal;
end

% Helix z-axis
% f=@(z)exp(z).*sin(z);g=@(z)exp(z).*cos(z);h=@(z)sqrt(2)*exp(z);