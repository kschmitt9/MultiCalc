function spacecurve(x_func, y_func, z_func, t, frame_rate)
    % Check if the parameter vector is provided, otherwise use a default range
    if nargin < 4
        t = linspace(0,2*pi, 100);
    end
    
    if nargin < 5
        frame_rate = 24; % Default frame rate (frames per second)
    end

    % Calculate the coordinates of the space curve
    x = x_func(t);
    y = y_func(t);
    z = z_func(t);

    % Initialize the plot and set axis labels
    fig = figure; % create a figure and save its handle
    h = plot3(x(1), y(1), z(1), 'LineWidth', 2);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    grid on;
    title('Archytas Curve');
    axis equal;

    % Set axis limits
    xlim([min(x) max(x)]);
    ylim([min(y) max(y)]);
    zlim([min(z) max(z)]);

    % Initialize the frames structure array
    frames(length(t)) = struct('cdata',[],'colormap',[]);

    % Set the view point for 3D plot
    % view(-44, 5); % Set the azimuth and elevation angles
    
    % Capture the first frame before entering the loop
    drawnow
    frames(1) = getframe(fig); % pass figure handle to getframe

    % Animate the curve
    dt = 1/frame_rate;
    for i = 2:length(t)
        % Update the plot with new data
        set(h, 'XData', x(1:i), 'YData', y(1:i), 'ZData', z(1:i));
        
        % Capture frame for GIF
        drawnow
        frames(i) = getframe(fig); % pass figure handle to getframe
        
        % Pause between frames
        pause(dt);
    end

    % Save the frames as a GIF
    filename = 'spacecurve.gif';
    for idx = 1:length(t)
        % Convert frame to image
        img = frame2im(frames(idx));
        
        % Convert the image to indexed image in colormap format
        [imind, cm] = rgb2ind(img,256);
        
        % Write frames to the GIF file
        if idx == 1
            imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', dt);
        elseif idx == length(t) % If it's the last frame
            imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', dt*24); % Set a higher delay time for the last frame
        else
            imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', dt);
        end
    end
end




% Examples

% line
% f=@(t) t; g=@(t) 1-2*t; h=@(t) 4+t/3;

% discontinuous
% f=@(z)z.^4;g=@(z)10*sin(z)./z;h=@(z)z.*exp(-z)-1;

% Helix y-axis
% f=@(z)cos(z);g=@(z)z;h=@(z)sin(z);

% Helix z-axis
% f=@(z)sin(z);g=@(z)cos(z);h=@(z)z;

% Cylinder-Plane
% f=@(z)cos(z);g=@(z)sin(z);h=@(z)2-cos(z);

% Toroidal Spiral
% f=@(z)(4+sin(20*z)).*cos(z);g=@(z)(4+sin(20*z)).*sin(z);h=@(z)cos(20*z);

% Trefoil Knot
% f=@(z)(2+cos(1.5*z)).*cos(z);g=@(z)(2+cos(1.5*z)).*sin(z);h=@(z)sin(1.5*z);

% Hyperbolic Paraboloid-Cylinder
% f=@(z)cos(z);g=@(z)sin(z);h=@(z)1-2*sin(z).^2;

% Arclength practice 1
% f=@(t) 2*sin(t); g=@(t) 4*t; h=@(t) 2*sin(t);

% Arclength practice 2
% f=@(t) exp(t).*sin(t); g=@(t) exp(t).*cos(t); h=@(t) sqrt(2)*exp(t);

% Archytas
% f=@(t) cos(t).^4./(1+sin(t).^2).^2; g=@(t) cos(t).*sin(2*t)./(1+sin(t).^2).^2; h = @(t) sin(2*t)./(sqrt(2)*(1+sin(t).^2));
