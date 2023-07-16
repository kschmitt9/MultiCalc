function skewlinesandplanes(P1, V1, P2, V2)
    % Create a range for the skew lines
    t = linspace(-10, 10, 100);
    
    % Calculate the points on the skew lines
    L1 = P1 + t'*V1;
    L2 = P2 + t'*V2;
    
    % Calculate the normal vector for the parallel planes
    N = cross(V1, V2);
    
    % Create a grid of points to plot the planes
    [X, Y] = meshgrid(-10:1:10, -10:1:10);
    
    % Calculate the Z coordinates for the planes containing the skew lines
    Z1 = (dot(N, P1) - N(1)*X - N(2)*Y) / N(3);
    Z2 = (dot(N, P2) - N(1)*X - N(2)*Y) / N(3);
    
    % Plot the skew lines
    figure;
    plot3(L1(:, 1), L1(:, 2), L1(:, 3), 'r', 'LineWidth', 2); hold on;
    plot3(L2(:, 1), L2(:, 2), L2(:, 3), 'b', 'LineWidth', 2);
    
    % Plot the parallel planes
    surf(X, Y, Z1, 'FaceAlpha', 0.5, 'FaceColor', 'r', 'EdgeColor', 'none');
    surf(X, Y, Z2, 'FaceAlpha', 0.5, 'FaceColor', 'b', 'EdgeColor', 'none');
    
    % Set the axis labels and title
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('Skew Lines and Parallel Planes');
    grid on;
    
    % Set the axis limits to define a fixed 3D cube
    axis equal;
    xlim([-10, 10]);
    ylim([-10, 10]);
    zlim([-10, 10]);
    
    % Display the 3D view
    view(3);
end

% Example problem
% P1=[1,3,4];V1=[2,-1,3];
% P2=[2,4,1];V2=[1,-2,1];
% skewlinesandplanes(P1, V1, P2, V2)