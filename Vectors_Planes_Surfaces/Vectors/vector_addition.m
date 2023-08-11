function vector_addition(A, B)
    % Set up figure
    fig = figure;
    view(3);
    hold on;

    % Calculate axis limits
    vec_addition = A + B;
    max_vals = max([A', B', vec_addition'], [], 2);
    min_vals = min([A', B', vec_addition',[0,0,0]'], [], 2);
    padding = .1; % You can adjust this value for more padding
    axis([min_vals(1)-padding, max_vals(1)+padding, ...
          min_vals(2)-padding, max_vals(2)+padding, ...
          min_vals(3)-padding, max_vals(3)+padding]);
    disp(max_vals)
    disp(min_vals)

    grid on;
    xlabel('x');
    ylabel('y');
    zlabel('z');
    view(-50,25)

    % Initial plot of vectors
    hA = quiver3(0, 0, 0, A(1), A(2), A(3), 'r', 'LineWidth', 1.5, 'autoscale','off');
    hB = quiver3(0, 0, 0, B(1), B(2), B(3), 'g', 'LineWidth', 1.5, 'autoscale','off');
    hC = quiver3(0, 0, 0, 0, 0, 0, 'b', 'LineWidth', 1.5, 'autoscale','off');

    % Add a legend
    legend([hA, hB, hC], {'$\mathbf{a}$', '$\mathbf{b}$', '$\mathbf{a} + \mathbf{b}$'}, 'Interpreter', 'latex','location','best');

    % File name
    gifFileName = 'vector_animation.gif';
    isFirstFrame = true;

    frame = getframe(fig);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);

    imwrite(imind, cm, gifFileName, 'gif', 'Loopcount', inf, 'DelayTime', 2);

    % Animate the transportation of B to the tip of A
    nSteps = 100;
    for k = 1:nSteps
        beta = k / nSteps;
        d = beta * A;

        % Update position of B
        hB.XData = d(1);
        hB.YData = d(2);
        hB.ZData = d(3);

        drawnow;
        
        % Capture the current frame
        frame = getframe(fig);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);

        % Write to the GIF File 
        imwrite(imind, cm, gifFileName, 'gif', 'WriteMode', 'append', 'DelayTime', 0.05);

        pause(0.1); % adjust the pause for desired animation speed
    end

    % Plot resultant vector
    hC.UData = vec_addition(1);
    hC.VData = vec_addition(2);
    hC.WData = vec_addition(3);
    % quiver3(0, 0, 0, vec_addition(1), vec_addition(2), vec_addition(3), 'b', 'LineWidth', 1.5, 'DisplayName', 'A + B','autoscale','off');

    % Capture the current frame with the resultant vector for a longer delay and append to the GIF
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);
    imwrite(imind, cm, gifFileName, 'gif', 'WriteMode', 'append', 'DelayTime', 4);  % 3 seconds delay for observation

    % Add legend
    legend('show', 'Location', 'best');
    hold off;
end

% Example
% v = [3, 2, 1];
% w = [1, 7, -1];
% vector_ops(v, w);
