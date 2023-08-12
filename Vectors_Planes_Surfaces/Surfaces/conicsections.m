function conicsections(cross_section)
    % Create the cone
    theta = linspace(0, 2*pi, 50);
    r = linspace(0, 1, 50);
    x = cos(theta') * r;
    y = sin(theta') * r;
    Z = sqrt(x.^2 + y.^2);

    % Plot the cone
    figure;
    surf(x, y, Z);
    shading interp;
    colormap(summer)
    hold on;
    surf(x, y, -Z);
    shading interp;
    xlabel('x');
    ylabel('y');
    zlabel('z');

    % Plot the specified cross-section
    switch lower(cross_section)
        case 'none'
        case 'line'
            x = linspace(-1, 1, 21)';
            y = zeros(21, 1);
            Z = x * ones(1, 21);
            surf(x, y, Z,'FaceColor',[41/256,53/256,149/256],'edgecolor','none');
            
        case 'hyperbola'
            x = linspace(-1, 1, 21)';
            y = 0.5 * ones(21, 1);
            Z = x * ones(1, 21);
            surf(x, y, Z,'FaceColor',[41/256,53/256,149/256],'edgecolor','none');
            
        case 'circle'
            x = linspace(-1, 1, 21);
            y = x;
            Z = 0.6 * ones(21);
            surf(x, y, Z,'FaceColor',[41/256,53/256,149/256],'edgecolor','none');
            
        case 'parabola'
            x = linspace(-1, 1, 21)';
            y = x;
            Z = (y + 0.25) * ones(1, 21);
            surf(x, y, Z,'FaceColor',[41/256,53/256,149/256],'edgecolor','none');
            
        otherwise
            error('Invalid cross-section type. Valid types: line, hyperbola, circle, parabola');
    end
end
