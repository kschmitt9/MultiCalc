function anicurvature(x_func, y_func, z_func, t)
    % Check if the parameter vector is provided, otherwise use a default range
    if nargin < 4 || isempty(t)
        t = linspace(0, 4*pi, 400);
    end
    h = t(2)-t(1);

    frame_rate = 24;

    % Calculate the coordinates of the space curve
    x = x_func(t); min_x=floor(min(x)-1); max_x=ceil(max(x)+1);
    y = y_func(t); min_y=floor(min(y)-1); max_y=ceil(max(y)+1);
    z = z_func(t); min_z=floor(min(z)-1); max_z=ceil(max(z)+1);

    % Calculate the first and second derivatives of the space curve
    x_diff = gradient(x,h); y_diff = gradient(y,h); z_diff = gradient(z,h);
    x_diff2 = gradient(x_diff,h); y_diff2 = gradient(y_diff,h); z_diff2 = gradient(z_diff,h);

    % Calculate the unit tangent and normal components
    T_mag = vecnorm([x_diff;y_diff;z_diff]);
    x_tan = x_diff./T_mag; y_tan = y_diff./T_mag; z_tan = z_diff./T_mag; % unit tangent components

    x_tand = gradient(x_tan,h); y_tand = gradient(y_tan,h); z_tand = gradient(z_tan,h);
    N_mag = vecnorm([x_tand;y_tand;z_tand]);
    x_n = x_tand./N_mag; y_n = y_tand./N_mag; z_n = z_tand./N_mag; % unit normal components

    % Initialize the figure and axis limits
    figure(1);
    set(gca, 'XLim', [min_x max_x], 'YLim', [min_y max_y], 'ZLim', [min_z max_z]);
    hold on;

    % Set tick values
    x_ticks = floor(min_x):ceil(max_x);
    y_ticks = floor(min_y):ceil(max_y);
    z_ticks = floor(min_z):ceil(max_z);
    set(gca, 'XTick', x_ticks, 'YTick', y_ticks, 'ZTick', z_ticks);

    % Preallocate the frames struct
    frames(length(t)-4) = struct('cdata',[],'colormap',[]);

    plot3(x, y, z, 'LineWidth', 2, 'color', 'k');
    xlabel('x');
    ylabel('y');
    zlabel('z');
    title('Archytas Curve');
    grid on;

    % Set the view point for 3D plot
    view(-127, 40); % Set the azimuth and elevation angles

    % Iterate through the values of t and update the plot
    dt = 1/frame_rate;
    for t_idx = 3:length(t)-2
        % Clear the current plot objects
        if t_idx > 3
            delete(tangent_vector);
            delete(normal_vector);
            delete(binormal_vector);
            delete(circle_of_curvature);
            % delete(normal_plane);
            % delete(osculating_plane);
        end
        
        % Calculate the unit tangent and normal vectors at t_idx
        T_val = [x_tan(t_idx),y_tan(t_idx),z_tan(t_idx)];
        N_val = [x_n(t_idx),y_n(t_idx),z_n(t_idx)];
        B_val = cross(T_val, N_val); 

        % Calculate the curvature at t_idx
        k_val = vecnorm(cross([x_diff(t_idx),y_diff(t_idx),z_diff(t_idx)], [x_diff2(t_idx),y_diff2(t_idx),z_diff2(t_idx)])) /  vecnorm([x_diff(t_idx),y_diff(t_idx),z_diff(t_idx)])^3;
        r_val = 1/k_val;
        
        % Evaluate the position of the point
        P_val = [x(t_idx), y(t_idx), z(t_idx)];

        % Plot tangent, normal, and binormal vectors
        tangent_vector = quiver3(P_val(1), P_val(2), P_val(3), T_val(1), T_val(2), T_val(3), 'r', 'LineWidth', 2);
        normal_vector = quiver3(P_val(1), P_val(2), P_val(3), N_val(1), N_val(2), N_val(3), 'b', 'LineWidth', 2);
        binormal_vector = quiver3(P_val(1), P_val(2), P_val(3), B_val(1), B_val(2), B_val(3), 'g', 'LineWidth', 2);

        % % Plot normal plane
        % [X, Y] = meshgrid(linspace(min(x), max(x), 100), linspace(min(y), max(y), 100));
        % if T_val(3) ~= 0
        %     Z = P_val(3) - T_val(1)*(X - P_val(1))/T_val(3) - T_val(2)*(Y - P_val(2))/T_val(3);
        % else
        %     Z = P_val(3)*ones(size(X));
        % end
        % normal_plane = surf(X, Y, Z, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
        % normal_plane.FaceColor = [1 0 0];

        % % Plot osculating plane
        % Z = P_val(3) - B_val(1)*(X - P_val(1))/B_val(3) - B_val(2)*(Y - P_val(2))/B_val(3);
        % osculating_plane = surf(X, Y, Z, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
        % osculating_plane.FaceColor = [0 0 1];

        % Plot circle of curvature in the normal plane
        theta = linspace(0, 2*pi, 100);
        circle_points = repmat(P_val+r_val*N_val, [100, 1]) + r_val * (cos(theta(:)) * N_val + sin(theta(:)) * T_val);
        % Filter out the points outside the viewing region
        within_limits = circle_points(:, 1) >= min_x & circle_points(:, 1) <= max_x ...
            & circle_points(:, 2) >= min_y & circle_points(:, 2) <= max_y ...
            & circle_points(:, 3) >= min_z & circle_points(:, 3) <= max_z;
        circle_points = circle_points(within_limits, :);
        circle_of_curvature = plot3(circle_points(:, 1), circle_points(:, 2), circle_points(:, 3), 'c', 'LineWidth', 2);

        lgd = legend('Space Curve', 'Tangent Vector', 'Normal Vector', 'Binormal Vector', ...
            'Circle of Curvature', 'Location', 'best');
        lgd.Position = [0.1 .8 0.1 0.2]; % You can adjust these values

        % Get the frame for the current plot
        drawnow;
        frames(t_idx) = getframe(gcf);

        % Pause between frames
        pause(dt);
    end

    % Save the frames as a GIF
    filename = 'anicurvature.gif';
    for idx = 3:length(t)-2
        % Convert frame to image
        img = frame2im(frames(idx));

        % Convert the image to indexed image in colormap format
        [imind, cm] = rgb2ind(img,256);

        % Write frames to the GIF file
        if idx == 3
            imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', dt);
        else
            imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', dt);
        end
    end

    hold off
end

