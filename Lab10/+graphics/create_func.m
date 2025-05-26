function [] = create_func(x, y)
    figure;
    plot(x, y, 'b-', 'LineWidth', 1.5);
    title('График функции y = sin(x) + 0.3x');
    xlabel('x');
    ylabel('y');
    grid on;
end