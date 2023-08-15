function thetaani()

    % Define the properties of the half-plane
    radius = 3;
    [x, z] = meshgrid(linspace(0,radius,100), linspace(-radius,radius,100));
    y = zeros(size(x));

    % Create a new figure
    f = figure(1);
    set(gca, 'XLim', [-3 3], 'YLim', [-3 3], 'ZLim', [-3 3]);
    view([-54,10]);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    hold on;
    
    % Create a handle to the surface object
    h = surf(x, y, z, 'FaceColor', 'interp', 'EdgeColor', 'none');
    colormap(summer);

    % Create a handle to the text label
    % theta = pi/2;
    t = text(-2.5, 2.5, 2.5, ['$\theta$: 0'], 'Color', 'k','Interpreter', 'latex');
    
    % Filename of the GIF file
    filename = 'animatedTheta.gif';
    
    for i = 1:100
        
        % Modify theta
        theta = i*2*pi/100;
        
        % Update the data of the surface object
        set(h, 'XData', x*cos(theta) - y*sin(theta), 'YData', x*sin(theta) + y*cos(theta));

        % Update the text label
        set(t, 'String', ['$\theta$: ', num2str(theta)]);
        
        % Capture frame for GIF
        drawnow 
        frame = getframe(f);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        
        % Write frame to GIF file
        if i == 1
            imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.1);
        else
            imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);
        end
        
    end
    
    hold off;
    
end
