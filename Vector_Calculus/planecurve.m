function planecurve(x_func, y_func, t, frame_rate)
    % Check if the parameter vector is provided, otherwise use a default range
    if nargin < 3
        t = linspace(0,2*pi, 100);
    end
    
    if nargin < 4
        frame_rate = 24; % Default frame rate (frames per second)
    end

    % Calculate the coordinates of the plane curve
    x = x_func(t);
    y = y_func(t);

    % Initialize the plot and set axis labels
    hold on
    h = plot(x(1), y(1), 'LineWidth', 2, 'color', 'red');
    xlabel('x');
    ylabel('y');
    grid on;

    % Initialize the frames structure array
    frames(length(t)) = struct('cdata',[],'colormap',[]);

    % Capture the first frame before entering the loop
    drawnow
    frames(1) = getframe(gcf); % pass figure handle to getframe

    % Animate the curve
    dt = 1/frame_rate;
    for i = 2:length(t)
        % Update the plot with new data
        set(h, 'XData', x(1:i), 'YData', y(1:i));
        
        % Capture frame for GIF
        drawnow
        frames(i) = getframe(gcf); % pass figure handle to getframe
        
        % Pause between frames
        pause(dt);
    end

    % Save the frames as a GIF
    filename = 'planecurve.gif';
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
