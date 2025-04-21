function [] = maingraphic(x, y, x_lin, yy) 
    figure
    subplot(1, 2, 1)
    plot(x, y, 'o', "MarkerfaceColor", "b");
    hold on;
    grid on;
    plot(x_lin, yy, '-r', 'LineWidth', 1);
    legend('Данные', 'fminsearch', 'Location', 'Best');
    title("Аппроксимация функции");
end