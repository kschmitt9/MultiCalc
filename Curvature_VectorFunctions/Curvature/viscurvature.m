function viscurvature(x_func, y_func, z_func, t)
    % Check if the parameter vector is provided, otherwise use a default range
    if nargin < 4 || isempty(t)
        t = linspace(0, 2*pi, 100);
    end
    h = t(2)-t(1);

    t_idx = 1*length(t)/5;

    % Calculate the coordinates of the space curve
    x = x_func(t);
    y = y_func(t);
    z = z_func(t);

    % Calculate the first and second derivatives of the space curve
    x_diff = gradient(x,h); y_diff = gradient(y,h); z_diff = gradient(z,h);
    x_diff2 = gradient(x_diff,h); y_diff2 = gradient(y_diff,h); z_diff2 = gradient(z_diff,h);

    % Calculate the unit tangent and normal components
    T_mag = vecnorm([x_diff;y_diff;z_diff]);
    x_tan = x_diff./T_mag; y_tan = y_diff./T_mag; z_tan = z_diff./T_mag; % unit tangent components

    x_tand = gradient(x_tan,h); y_tand = gradient(y_tan,h); z_tand = gradient(z_tan,h);
    N_mag = vecnorm([x_tand;y_tand;z_tand]);
    x_n = x_tand./N_mag; y_n = y_tand./N_mag; z_n = z_tand./N_mag; % unit normal components
    
    % Calculate the unit tangent and normal vectors at t_idx
    T_val = [x_tan(t_idx),y_tan(t_idx),z_tan(t_idx)];
    N_val = [x_n(t_idx),y_n(t_idx),z_n(t_idx)];
    B_val = cross(T_val, N_val); 

    % Calculate the curvature at t_idx
    k_val = vecnorm(cross([x_diff(t_idx),y_diff(t_idx),z_diff(t_idx)], [x_diff2(t_idx),y_diff2(t_idx),z_diff2(t_idx)])) /  vecnorm([x_diff(t_idx),y_diff(t_idx),z_diff(t_idx)])^3;
    r_val = 1/k_val;
    
    % Evaluate the position of the point
    P_val = [x(t_idx), y(t_idx), z(t_idx)];

    % Initialize the plot and set axis labels
    figure;
    plot3(x, y, z, 'LineWidth', 2,'color','k');
    xlabel('x');
    ylabel('y');
    zlabel('z');
    grid on;
    axis equal;
    hold on;

    % Plot tangent, normal, and binormal vectors
    quiver3(P_val(1), P_val(2), P_val(3), T_val(1), T_val(2), T_val(3), 'r', 'LineWidth', 2);
    quiver3(P_val(1), P_val(2), P_val(3), N_val(1), N_val(2), N_val(3), 'b', 'LineWidth', 2);
    % quiver3(P_val(1), P_val(2), P_val(3), B_val(1), B_val(2), B_val(3), 'g', 'LineWidth', 2);

    % % Plot normal plane
    % [X, Y] = meshgrid(linspace(min(x), max(x), 100), linspace(min(y), max(y), 100));
    % if T_val(3) ~= 0
    %     Z = P_val(3) - T_val(1)*(X - P_val(1))/T_val(3) - T_val(2)*(Y - P_val(2))/T_val(3);
    % else
    %     Z = P_val(3)*ones(size(X));
    % end
    % s = surf(X, Y, Z, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    % s.FaceColor = [1 0 0];

    % % Plot osculating plane
    % Z = P_val(3) - B_val(1)*(X - P_val(1))/B_val(3) - B_val(2)*(Y - P_val(2))/B_val(3);
    % s2 = surf(X, Y, Z, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    % s2.FaceColor = [0 0 1];

    % Plot circle of curvature in the normal plane
    theta = linspace(0, 2*pi, 100);
    circle_points = repmat(P_val+r_val*N_val, [100, 1]) + r_val * (cos(theta(:)) * N_val + sin(theta(:)) * T_val);
    plot3(circle_points(:, 1), circle_points(:, 2), circle_points(:, 3), 'c', 'LineWidth', 2);

    % Set axis limits
    xlim([min(x)-1 max(x)+1]);
    ylim([min(y)-1 max(y)+1]);
    zlim([min(z)-1 max(z)+1]);

    % Add legend
    legend('Space Curve', 'Tangent Vector', 'Normal Vector', 'Binormal Vector', ...
        'Normal Plane', 'Osculating Plane','Circle of Curvature', 'Location', 'best');

    hold off;
end