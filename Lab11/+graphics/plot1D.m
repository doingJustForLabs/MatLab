function plot1D(func, a, b, x_hist, y_hist, x_final, y_final, methodName)
    % Вспомогательная функция для отображения результатов 1D оптимизации
    % func - указатель на функцию
    % a, b - исходный интервал (для построения графика функции)
    % x_hist - история точек x на шагах поиска
    % y_hist - история значений функции f(x) на шагах поиска
    % x_final - найденный экстремум x
    % y_final - значение функции в найденном экстремуме f(x_final)
    % methodName - название метода для заголовка графика
    
    figure;
    fplot(func, [a, b], 'LineWidth', 1.5);
    hold on;
    
    % Уникальные точки истории, чтобы не было каши на графике
    if ~isempty(x_hist) && ~isempty(y_hist)
        unique_hist_xy = unique([x_hist(:), y_hist(:)], 'rows');
        plot(unique_hist_xy(:,1), unique_hist_xy(:,2), 'o-', 'MarkerFaceColor', 'b', 'DisplayName', 'Шаги поиска');
    end
    
    plot(x_final, y_final, 'r*', 'MarkerSize', 10, 'LineWidth', 1.5, 'DisplayName', 'Найденный экстремум');
    
    title(['Оптимизация функции: ', methodName]);
    xlabel('x');
    ylabel('f(x)');
    legend('show', 'Location', 'best');
    grid on;
    hold off;
    drawnow; % Обновить график немедленно
end