function graphic(x, y, xx, y_pol)
    figure;
    plot(x, y, 'o', 'MarkerFaceColor', 'b');
    hold on;
    plot(xx, y_pol, 'r-', 'LineWidth', 1);
    % plot(xx, y_spline, 'r-', 'LineWidth', 1);
    xlabel('Температура (C)');
    ylabel('Вязкость (сP)');
    title('Аппроксимация полиномом 3-й степени');
    grid on;
    legend('Данные', 'Полином', 'Location', 'Best');
end