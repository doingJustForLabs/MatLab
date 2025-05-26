function plot2D(func2D_handle, p_history, val_history, p_final, val_final, method_name, p_start)
    figure;
    sgtitle(['Результаты оптимизации: ', method_name], 'FontSize', 14);
    
    if isempty(p_history)
        x_coords_all = [p_start(1), p_final(1)];
        y_coords_all = [p_start(2), p_final(2)];
    else
        x_coords_all = [p_history(1,:), p_start(1), p_final(1)];
        y_coords_all = [p_history(2,:), p_start(2), p_final(2)];
    end
    
    x_min_plot = min(x_coords_all) - 1;
    x_max_plot = max(x_coords_all) + 1;
    y_min_plot = min(y_coords_all) - 1;
    y_max_plot = max(y_coords_all) + 1;
    
    % Если диапазон слишком мал (например, все точки совпали)
    if x_max_plot - x_min_plot < 1e-3, x_min_plot = x_min_plot-0.5; x_max_plot = x_max_plot+0.5; end
    if y_max_plot - y_min_plot < 1e-3, y_min_plot = y_min_plot-0.5; y_max_plot = y_max_plot+0.5; end
    
    [X_grid, Y_grid] = meshgrid(linspace(x_min_plot, x_max_plot, 100), ...
                                linspace(y_min_plot, y_max_plot, 100));
    Z_grid = zeros(size(X_grid));
    for i = 1:size(X_grid,1)
        for j = 1:size(X_grid,2)
            Z_grid(i,j) = func2D_handle(X_grid(i,j), Y_grid(i,j));
        end
    end
    
    % Контурный график
    subplot(1,2,1);
    contour(X_grid, Y_grid, Z_grid, 50); 
    hold on;
    if ~isempty(p_history)
        plot(p_history(1,:), p_history(2,:), 'r.-', 'LineWidth', 1.5, 'MarkerSize', 8, 'DisplayName', 'Траектория поиска');
    end
    plot(p_start(1), p_start(2), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b', 'DisplayName', 'Старт');
    if ~isnan(val_final) 
        plot(p_final(1), p_final(2), 'gp', 'MarkerSize', 12, 'MarkerFaceColor', 'g', 'DisplayName', 'Найденный минимум');
    end
    xlabel('x'); ylabel('y');
    title('Контурный график и шаги');
    legend('show', 'Location', 'best');
    axis equal; 
    grid on;
    colorbar;
    hold off;
    
    % 3D Поверхность
    subplot(1,2,2);
    surf(X_grid, Y_grid, Z_grid, 'EdgeColor', 'none', 'FaceAlpha', 0.8);
    hold on;
    if ~isempty(p_history) && ~isempty(val_history)
        plot3(p_history(1,:), p_history(2,:), val_history, 'r.-', 'LineWidth', 2, 'MarkerSize', 10, 'DisplayName', 'Траектория поиска');
    end
    plot3(p_start(1), p_start(2), func2D_handle(p_start(1), p_start(2)), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b', 'DisplayName', 'Старт');
    if ~isnan(val_final)
        plot3(p_final(1), p_final(2), val_final, 'gp', 'MarkerSize', 12, 'MarkerFaceColor', 'g', 'DisplayName', 'Найденный минимум');
    end
    xlabel('x'); ylabel('y'); zlabel('f(x,y)');
    title('3D поверхность и шаги');
    legend('show', 'Location', 'best');
    grid on;
    view(30, 30); % Угол обзора
    hold off;
    
    drawnow;
end