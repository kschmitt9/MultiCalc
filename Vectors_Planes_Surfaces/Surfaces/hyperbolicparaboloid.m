function hyperbolicparaboloid(a, b)
    % Create a grid of points to plot the hyperbolic paraboloid
    X = linspace(-1, 1, 41)' * ones(1, 41);
    Y = ones(41, 1) * linspace(-1, 1, 41);
    
    % Calculate the Z coordinates for the hyperbolic paraboloid
    Z = a * X.^2 - b * Y.^2;
    
    % Plot the hyperbolic paraboloid
    figure;
    surf(X, Y, Z);
    shading interp;
    colormap(summer);
    hold on;
    
    % Set axis ticks and labels
    xticks([-1, 0, 1]);
    yticks([-1, 0, 1]);
    zticks([0, 1, 2]);
    xlabel('$x$', 'interpreter', 'latex', 'fontsize', 28);
    ylabel('$y$', 'interpreter', 'latex', 'fontsize', 28);
    zlabel('$z$', 'interpreter', 'latex', 'fontsize', 28);
    
    % Plot contour lines
    contour(X, Y, Z, [.05,.05],'color','r','linewidth',2);
    contour(X, Y, Z, [-.05,-.05],'color','b','linewidth',2);

    % Create dummy line objects for legend
    h1 = line(0, 0, 'Color', 'r','linewidth',2);
    h2 = line(0, 0, 'Color', 'b','linewidth',2);

    legend([h1, h2],{'$z=.05$', '$z=-.05$'}, 'Interpreter', 'latex','location','best');
end

% Example
% a = 1;
% b = 1;
% hyperbolicparaboloid(a, b);
