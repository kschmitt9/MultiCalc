function planecurve2(x_func1, y_func1, t1, x_func2, y_func2, t2, frame_rate)
    % Check if the parameter vector is provided, otherwise use a default range
    if nargin < 3 || isempty(t1)
        t1 = linspace(0,2*pi, 100);
    end
    
    if nargin < 5 || isempty(t2)
        t2 = linspace(0,2*pi, 100);
    end
    
    if nargin < 7
        frame_rate = 24; % Default frame rate (frames per second)
    end

    % Calculate the coordinates of the plane curves
    x1 = x_func1(t1);
    y1 = y_func1(t1);
    x2 = x_func2(t2);
    y2 = y_func2(t2);

    % Initialize the plot and set axis labels
    hold on
    h1 = plot(x1(1), y1(1), 'LineWidth', 2, 'color', 'red');
    h2 = plot(x2(1), y2(1), 'LineWidth', 2, 'color', 'green');
    xlabel('x');
    ylabel('y');
    grid on;

    % Initialize the frames structure array for the longest curve
    max_t_length = max(length(t1), length(t2));
    frames(max_t_length) = struct('cdata',[],'colormap',[]);

    % Capture the first frame before entering the loop
    drawnow
    frames(1) = getframe(gcf); % pass figure handle to getframe

    % Animate the curves
    dt = 1/frame_rate;
    for i = 2:max_t_length
        % Update the plots with new data
        if i <= length(t1)
            set(h1, 'XData', x1(1:i), 'YData', y1(1:i));
        end
        if i <= length(t2)
            set(h2, 'XData', x2(1:i), 'YData', y2(1:i));
        end
        
        % Capture frame for GIF
        drawnow
        frames(i) = getframe(gcf); % pass figure handle to getframe
        
        % Pause between frames
        pause(dt);
    end

    % Save the frames as a GIF
    filename = 'planecurves.gif';
    for idx = 1:max_t_length
        % Convert frame to image
        img = frame2im(frames(idx));
        
        % Convert the image to indexed image in colormap format
        [imind, cm] = rgb2ind(img,256);
        
        % Write frames to the GIF file
        if idx == 1
            imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', dt);
        elseif idx == max_t_length % If it's the last frame
            imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', dt*24); % Set a higher delay time for the last frame
        else
            imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', dt);
        end
    end
end
