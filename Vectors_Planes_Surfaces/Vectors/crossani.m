function crossani(A, B_original)
    % Ensure A and B_original are column vectors for computation consistency
    A = A(:);
    B_original = B_original(:);

    v = cross(A, B_original);
    v = v / norm(v); % Make it a unit vector

    theta = linspace(0, 2*pi, 100); % angle varying from 0 to 2pi

    fig = figure;
    axis([-1 1 -1 1 -1 1]); % set the plot limits
    hold on;
    grid on;
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Z-axis');
    view(-30,30);

    % Create dummy plots for the legend
    h1 = quiver3(0, 0, 0, A(1), A(2), A(3), 'r', 'LineWidth', 2,'autoscale','off');
    h2 = quiver3(0, 0, 0, 0, 0, 0, 'b', 'LineWidth', 2,'autoscale','off');
    h3 = quiver3(0, 0, 0, 0, 0, 0, 'g', 'LineWidth', 2,'autoscale','off');

    % Add a legend
    legend([h1, h2, h3], {'$\mathbf{a}$', '$\mathbf{b}$', '$\mathbf{a} \times \mathbf{b}$'}, 'Interpreter', 'latex','location','northeast');

    for i = 1:length(theta)
        % Rotate vector B around the axis perpendicular to the plane spanned by A and B_original
        R = rotationMatrix(v, theta(i));
        B = R * B_original;

        % Calculate and plot the cross product of A and B
        C = cross(A, B);

        % Update the B and C vectors using the quiver3 handles
        h2.UData = B(1);
        h2.VData = B(2);
        h2.WData = B(3);
        h3.UData = C(1);
        h3.VData = C(2);
        h3.WData = C(3);

        drawnow;

        % Capture the current frame as an image
        frame = getframe(fig);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);

        % Write to the GIF File 
        if i == 1
            imwrite(imind,cm,'crossani.gif','gif', 'Loopcount',inf, 'DelayTime',0.05);
        else
            imwrite(imind,cm,'crossani.gif','gif','WriteMode','append', 'DelayTime',0.05);
        end
    end
end

function R = rotationMatrix(axis, theta)
    % Computes the rotation matrix around the given axis by the given angle
    ct = cos(theta);
    st = sin(theta);
    omct = 1 - ct;
    x = axis(1);
    y = axis(2);
    z = axis(3);

    R = [x*x*omct + ct, x*y*omct - z*st, x*z*omct + y*st;
         x*y*omct + z*st, y*y*omct + ct, y*z*omct - x*st;
         x*z*omct - y*st, y*z*omct + x*st, z*z*omct + ct];
end
