function vector_ops(A, B)
    % Vector operations
    vec_addition = A + B;
    vec_subtraction = A - B;

    % Set up figure
    figure;
    view(3);
    hold on;
    axis equal;
    grid on;
    xlabel('x');
    ylabel('y');
    zlabel('z');

    % Plot vectors
    quiver3(0, 0, 0, A(1), A(2), A(3), 'r', 'LineWidth', 1.5, 'DisplayName', 'A');
    quiver3(0, 0, 0, B(1), B(2), B(3), 'g', 'LineWidth', 1.5, 'DisplayName', 'B');
    % quiver3(0, 0, 0, vec_addition(1), vec_addition(2), vec_addition(3), 'b', 'LineWidth', 1.5, 'DisplayName', 'A + B');
    % quiver3(0, 0, 0, vec_subtraction(1), vec_subtraction(2), vec_subtraction(3), 'c', 'LineWidth', 1.5, 'DisplayName', 'A - B');

    % Add legend
    legend('show', 'Location', 'best');
    hold off;
end
