function conicsections(cross_section)
    % Create the cone
    theta = linspace(0, 2*pi, 100);
    r = linspace(0, 1, 100);
    x = cos(theta') * r;
    y = sin(theta') * r;
    Z = sqrt(x.^2 + y.^2);

    % Plot the cone
    figure;
    surf(x, y, Z);
    hold on;
    surf(x, y, -Z);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    title('$z^2=x^2+y^2$', 'interpreter', 'latex');

    % Plot the specified cross-section
    switch lower(cross_section)
        case 'none'
        case 'line'
            x = linspace(-1, 1, 21)';
            y = zeros(21, 1);
            Z = x * ones(1, 21);
            surf(x, y, Z);
            
        case 'hyperbola'
            x = linspace(-1, 1, 21)';
            y = 0.5 * ones(21, 1);
            Z = x * ones(1, 21);
            surf(x, y, Z);
            
        case 'circle'
            x = linspace(-1, 1, 21);
            y = x;
            Z = 0.6 * ones(21);
            surf(x, y, Z);
            
        case 'parabola'
            x = linspace(-1, 1, 21)';
            y = x;
            Z = (y + 0.25) * ones(1, 21);
            surf(x, y, Z);
            
        otherwise
            error('Invalid cross-section type. Valid types: line, hyperbola, circle, parabola');
    end
end
