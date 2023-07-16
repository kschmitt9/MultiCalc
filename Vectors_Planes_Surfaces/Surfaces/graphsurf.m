function graphsurf(f)
    % Create a grid of points to plot the 2D function
    [X, Y] = meshgrid(linspace(-1, 2, 101),linspace(-4, 1, 101));
    
    % Calculate the Z coordinates for the function
    Z = f(X, Y);
    
    % Plot the function
    figure;
    h = surf(X, Y, Z, 'FaceColor', 'interp', 'EdgeColor', 'none');
    h.CData = Z; % Set color data to be Z data
    % caxis([-2.386294361119891,-0.189069783783671]); % Set color axis to be within desired Z limit
    % zlim([-2.386294361119891,-0.189069783783671])
    % caxis([min(min(Z)),max(max(Z))]); % Set color axis based on max/min Z
    % zlim([min(min(Z)),max(max(Z))])
    shading interp;
    colormap(summer);
    hold on;
    
    % Set axis ticks and labels
    % xticks([-1, 0, 1]);
    % yticks([-1, 0, 1]);
    % zticks([min(Z(:)), 0, max(Z(:))]);
    xlabel('$x$', 'interpreter', 'latex', 'fontsize', 28);
    ylabel('$y$', 'interpreter', 'latex', 'fontsize', 28);
    zlabel('$z$', 'interpreter', 'latex', 'fontsize', 28);
end

% Elliptic Paraboloid
% f = @(x,y) 2*x.^2+y.^2+1;

% Monkey Saddle
% f = @(x, y) x.^3-3*x.*y.^2;

