function pyth3d(v1, v2)
    % Create a parallelogram using the input vectors
    P = [0, 0, 0];
    A = v1;
    B = v2;
    C = v1 + v2;

    % Create the xy, xz, and yz projections of the parallelogram
    xy_proj = [P(1:2); A(1:2); C(1:2); B(1:2); P(1:2)];
    xz_proj = [P([1, 3]); A([1, 3]); C([1, 3]); B([1, 3]); P([1, 3])];
    yz_proj = [P([2, 3]); A([2, 3]); C([2, 3]); B([2, 3]); P([2, 3])];

    % Initialize the plot
    figure;

    % Plot the solid parallelogram
    fill3([P(1), A(1), C(1), B(1), P(1)], [P(2), A(2), C(2), B(2), P(2)], [P(3), A(3), C(3), B(3), P(3)], 'y', 'FaceAlpha', 0.3);
    hold on;

    % Plot the xy projection with solid color
    fill3(xy_proj(:, 1), xy_proj(:, 2), zeros(size(xy_proj, 1), 1), 'r', 'FaceAlpha', 0.3);

    % Plot the xz projection with solid color
    fill3(xz_proj(:, 1), zeros(size(xz_proj, 1), 1), xz_proj(:, 2), 'g', 'FaceAlpha', 0.3);

    % Plot the yz projection with solid color
    fill3(zeros(size(yz_proj, 1), 1), yz_proj(:, 1), yz_proj(:, 2), 'b', 'FaceAlpha', 0.3);

    % Set axis labels and title
    xlabel('x'); ylabel('y'); zlabel('z');
    title('3D Pythagorean Theorem');
    grid on; axis equal;
    hold off;
end

% Example
% v1 = [1, 2, 3];
% v2 = [3, 2, 1];
% pyth3d(v1, v2);
