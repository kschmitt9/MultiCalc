function dirderiv_ani(f_sym, a, b, t, rng, n_frames)
    % Initialize symbolic variables
    syms x y;

    % Compute the gradient
    grad_f = [diff(f_sym, x), diff(f_sym, y)];

    % Set up domain
    [x_vals_mesh, y_vals_mesh] = meshgrid(t, t);

    % Convert symbolic function to MATLAB function
    f = matlabFunction(f_sym);

    % Compute z values
    z_vals = f(x_vals_mesh, y_vals_mesh);

    % Find z range
    z_min = min(z_vals(:));
    z_max = max(z_vals(:));

    % Set up figure and plot initial surface
    h = figure;
    surf(x_vals_mesh, y_vals_mesh, z_vals, 'EdgeColor', 'none', 'FaceColor', 'interp', 'FaceAlpha', 0.6);
    colormap(summer);
    hold on;
    ax = gca;
    ax.XLim = [min(t) max(t)];
    ax.YLim = [min(t) max(t)];
    zlim([z_min + rng(1), z_max + rng(2)]);
    view(150,12);

    zLimits = zlim(ax);
    directionText = text(ax.XLim(2)*.5, ax.YLim(2)*1.2, zLimits(2)*1.25, '', 'HorizontalAlignment', 'right', 'FontSize', 10);
    

    % Loop over each frame
    for i = 1:n_frames
        theta = 2 * pi * (i-1) / n_frames;
        u = [cos(theta), sin(theta)];
        u_norm = u / norm(u);

        % Compute the directional derivative
        dir_deriv = dot(grad_f, u_norm);
        dir_deriv_fun = matlabFunction(dir_deriv,'Vars',[x, y]);
        dir_deriv_value = dir_deriv_fun(a, b);

        % Display direction and value of the directional derivative
        directionStr = sprintf('u = [%.2f, %.2f], Directional Derivative = %.2f', cos(theta), sin(theta), dir_deriv_value);
        set(directionText, 'String', directionStr);

        % Compute z0 at point (a, b)
        z0 = f(a, b);

        % Calculate tangent line and cross-section
        t_positive = t(t >= 0);  % Only consider non-negative values
        tangent_line_u_positive = dir_deriv_fun(a, b) * t_positive + z0;
        cross_section_u = arrayfun(@(s) f(a + u_norm(1)*s, b + u_norm(2)*s), t);

        % Plot tangent line and cross-section
        plot3(a + u_norm(1)*t_positive, b + u_norm(2)*t_positive, tangent_line_u_positive, 'b', 'LineWidth', 2);
        plot3(a + u_norm(1)*t, b + u_norm(2)*t, cross_section_u, 'Color', [87/255, 181/255, 254/255], 'LineWidth', 2);

        % Capture the frame
        F(i) = getframe(h);

        % Clear lines (but not the surface) for the next frame
        children = get(gca, 'Children');
        delete(children(1:2));
    end

    % Save as an animated gif
    filename = 'animation.gif';
    for i = 1:n_frames
        im = frame2im(F(i));
        [imind, map] = rgb2ind(im, 256); % Convert to indexed image
        if i == 1
            imwrite(imind, map, filename, 'gif', 'LoopCount', Inf, 'DelayTime', .125);
        else
            imwrite(imind, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', .125);
        end
    end

    hold off;
end
