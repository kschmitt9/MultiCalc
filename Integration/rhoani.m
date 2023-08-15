function rhoani()

    % Define the properties of the sphere
    radius = 2;
    [x, y, z] = sphere;
    
    % Create a new figure
    f = figure(1);
    set(gca, 'XLim', [-3 3], 'YLim', [-3 3], 'ZLim', [-3 3]);
    view([-54,10]);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    hold on;
    
    % Create a handle to the surface object
    h = surf(radius*x, radius*y, radius*z,'FaceColor', 'interp', 'EdgeColor', 'none');
    colormap(summer);

    % Create a handle to the text label
    t = text(-2.5, 2.5, 2.5, ['$\rho$: ', num2str(radius)], 'Color', 'k','Interpreter', 'latex');
    
    % Preallocate data (for storing frame data)
    mov = struct('cdata', cell(1,100), 'colormap', cell(1,100));
    
    % Filename of the GIF file
    filename = 'animatedSphere.gif';
    
    for i = 1:100
        
        % Modify the radius
        radius = 2 + sin(i*2*pi/100);
        
        % Update the data of the surface object
        set(h, 'XData', radius*x, 'YData', radius*y, 'ZData', radius*z);

        % Update the text label
        set(t, 'String', ['$\rho$: ', num2str(radius)]);
        
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
    