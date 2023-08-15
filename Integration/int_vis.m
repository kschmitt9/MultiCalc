function int_vis(r, u_range, v_range, delta)
    if nargin < 4
        delta = 10;
    end
    
    % Create a grid of points to plot the 2D function
    [U, V] = meshgrid(linspace(u_range(1), u_range(2), delta+1), linspace(v_range(1), v_range(2), delta+1));
    
    % Calculate the X, Y, Z coordinates for the function
    % Assume r outputs a 3D matrix where the first layer is X, the second is Y, and the third is Z
    R = r(U, V);
    X = R(:,:,1);
    Y = R(:,:,2);
    Z = R(:,:,3);
    
    % Plot the function
    figure;
    h = surf(X, Y, Z, 'FaceColor', 'interp', 'EdgeColor', 'none','facealpha',.85);
    h.CData = Z; % Set color data to be Z data
    shading interp;
    colormap(summer);
    hold on;
    
    % Draw the rectangles illustrating volume
    dU = (u_range(2) - u_range(1)) / delta;
    dV = (v_range(2) - v_range(1)) / delta;
    
    for i = 1:delta
        for j = 1:delta
            x0 = X(i, j);
            y0 = Y(i, j);
            z0 = 0; % start from XY plane
            z1 = Z(i, j);
            
            % Draw sides and top of the block
            fill3_blocks(x0, y0, z0, dU, dV, z1, [43/255,53/255,132/255], [1,1,1],1);
        end
    end
    
    % Set axis ticks and labels
    xlabel('$x$', 'interpreter', 'latex', 'fontsize', 28);
    ylabel('$y$', 'interpreter', 'latex', 'fontsize', 28);
    zlabel('$z$', 'interpreter', 'latex', 'fontsize', 28);

    % Dummy plot for legend
    h_block = fill3([NaN, NaN], [NaN, NaN], [NaN, NaN], [43/255,53/255,132/255], 'edgecolor', 'k'); 
    legend([h, h_block], {'Surface', 'Blocks'}, 'Location', 'best');
end

function fill3_blocks(x0, y0, z0, dU, dV, z_rand, faceColor, edgeColor,faceAlpha)
    fill3([x0, x0, x0+dU, x0+dU], [y0, y0+dV, y0+dV, y0], [z0, z0, z0, z0], faceColor,'edgecolor',edgeColor,'facealpha',faceAlpha); % bottom
    fill3([x0, x0, x0+dU, x0+dU], [y0, y0+dV, y0+dV, y0], [z_rand, z_rand, z_rand, z_rand], faceColor,'edgecolor',edgeColor,'facealpha',faceAlpha); % top
    fill3([x0, x0, x0, x0], [y0, y0, y0+dV, y0+dV], [z0, z_rand, z_rand, z0], faceColor,'edgecolor',edgeColor,'facealpha',faceAlpha); % front
    fill3([x0+dU, x0+dU, x0+dU, x0+dU], [y0, y0, y0+dV, y0+dV], [z0, z_rand, z_rand, z0], faceColor,'edgecolor',edgeColor,'facealpha',faceAlpha); % back
    fill3([x0, x0+dU, x0+dU, x0], [y0, y0, y0, y0], [z0, z0, z_rand, z_rand], faceColor,'edgecolor',edgeColor,'facealpha',faceAlpha); % left
    fill3([x0, x0+dU, x0+dU, x0], [y0+dV, y0+dV, y0+dV, y0+dV], [z0, z0, z_rand, z_rand], faceColor,'edgecolor',edgeColor,'facealpha',faceAlpha); % right
end