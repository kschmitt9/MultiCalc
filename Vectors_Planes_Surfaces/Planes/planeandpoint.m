function planeandpoint(N, P0, P1)
    % Create a grid of points to plot the plane
    [X, Y] = meshgrid(-10:1:10, -10:1:10);
    
    % Calculate the Z coordinates for the plane
    Z = (dot(N, P0) - N(1)*X - N(2)*Y) / N(3);
    
    % Plot the plane
    figure;
    surf(X, Y, Z, 'FaceAlpha', 0.5, 'FaceColor', 'r', 'EdgeColor', 'none');
    hold on;
    
    % Plot the point not on the plane
    plot3(P1(1), P1(2), P1(3), 'b', 'MarkerSize', 10, 'LineWidth', 2);
    
    % Set the axis labels and title
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('Plane and Point not on the Plane');
    grid on;
    
    % Set the axis limits to define a fixed 3D cube
    axis equal;
    xlim([-10, 10]);
    ylim([-10, 10]);
    zlim([-10, 10]);
    
    % Display the 3D view
    view(3);
end

% Example
% N = [1, 1, 1];
% P0 = [1, 1, 1];
% P1 = [5, 5, 10];

% planeandpoint(N, P0, P1);