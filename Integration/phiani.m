function phiani()

    % Define the properties of the cone
    radius = 3;
    height = 3;
    [x, y, z] = cylinder([0 radius],100);
    z = z*height;
    
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
    t = text(-2.5, 2.5, 2.5, ['$\phi$: 0'], 'Color', 'k','Interpreter', 'latex');
    
    % Filename of the GIF file
    filename = 'animatedPhi.gif';
    
    for i = 1:100
        
        % Modify phi
        phi = i*pi/100;
        
        % Update the data of the surface object
        set(h, 'ZData', z*cos(phi));

        % Update the text label
        set(t, 'String', ['$\phi$: ', num2str(phi)]);
        
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
