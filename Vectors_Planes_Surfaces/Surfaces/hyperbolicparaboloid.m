function hyperbolicparaboloid(a, b)
    % Create a grid of points to plot the hyperbolic paraboloid
    X = linspace(-1, 1, 41)' * ones(1, 41);
    Y = ones(41, 1) * linspace(-1, 1, 41);
    
    % Calculate the Z coordinates for the hyperbolic paraboloid
    Z = a * X.^2 - b * Y.^2;
    
    % Plot the hyperbolic paraboloid
    figure;
    surf(X, Y, Z);
    hold on;
    
    % Set axis ticks and labels
    xticks([-1, 0, 1]);
    yticks([-1, 0, 1]);
    zticks([0, 1, 2]);
    xlabel('$x$', 'interpreter', 'latex', 'fontsize', 28);
    ylabel('$y$', 'interpreter', 'latex', 'fontsize', 28);
    zlabel('$z$', 'interpreter', 'latex', 'fontsize', 28);
    
    % Plot contour lines
    contour(X, Y, Z, [0.1,-0.1],'color','r');
    
    % Remove tick labels
    ax = gca;
    ax.XAxis.TickLabels = {' ', ' ', ' '};
    ax.YAxis.TickLabels = {' ', ' ', ' '};
    ax.ZAxis.TickLabels = {' ', ' ', ' '};
    
    % Add custom labels for ticks
    text(0, -1.2, -0.1, '$0$', 'interpreter', 'latex', 'fontsize', 20);
    text(-1.3, 0, 0, '$0$', 'interpreter', 'latex', 'fontsize', 20);
    text(-1, 1.3, .1, '$1$', 'interpreter', 'latex', 'fontsize', 20);
end

% Example
% a = 1;
% b = 1;
% hyperbolicparaboloid(a, b);
