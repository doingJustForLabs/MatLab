function grafik(sol_mpi, sol_newton)
    % Создаем сетку значений x
    x = linspace(-5, 10, 1000);
    
    % Вычисляем y для каждого уравнения
    y1 = (2 - 3*sin(x).*cos(x)).^(1/3);
    y2 = (3*x + sin(x) - 5) / 2;
    
    % Создаем график
    figure;
    plot(x, real(y1), 'b-', 'LineWidth', 1.5);  % Синяя линия - первое уравнение
    hold on;
    plot(x, y2, 'r-', 'LineWidth', 1.5);       % Красная линия - второе уравнение
    grid on;
    xlabel('x', 'FontSize', 12);
    ylabel('y', 'FontSize', 12);
    title('Графики уравнений и решений', 'FontSize', 14);
    
    % Отмечаем решение МПИ зеленым квадратом
    if ~isempty(sol_mpi) && all(isfinite(sol_mpi))
        plot(sol_mpi(1), sol_mpi(2), 's', 'Color', [0 0.5 0], ...
            'MarkerSize', 10, 'MarkerFaceColor', [0 0.7 0], ...
            'LineWidth', 1.2, 'DisplayName', 'Решение МПИ');
    end
    
    % Отмечаем решение Ньютона синим ромбом
    if ~isempty(sol_newton) && all(isfinite(sol_newton))
        plot(sol_newton(1), sol_newton(2), 'd', 'Color', [0 0 0.8], ...
            'MarkerSize', 10, 'MarkerFaceColor', [0.2 0.2 1], ...
            'LineWidth', 1.2, 'DisplayName', 'Решение Ньютона');
    end
    
    diff = abs(y1 - y2);
    [~, idx] = min(diff);
    x_approx = x(idx);
    y_approx = y2(idx);
    
    % fprintf('Приближенное пересечение: x ≈ %f, y ≈ %f\n', x_approx, y_approx);
    hold on;
    plot(x_approx, y_approx, 'go', 'MarkerSize', 10, 'LineWidth', 2);
    
    % Настраиваем отображение
    legend('show', 'Location', 'best');
    axis equal;
    xlim([-2 4]);
    ylim([-1 3]);
    hold off;
end