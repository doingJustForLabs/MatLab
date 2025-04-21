function [] = dfGraphic(x_lin, df, d2f) 
    subplot(1, 2, 2)
    hold on;
    plot(x_lin, df(x_lin), 'r--', 'LineWidth', 1);
    plot(x_lin, d2f(x_lin), 'g:', 'LineWidth', 1);
    grid on;
    title("Функции производных");
    legend("f'", "f''", 'Location', 'Best');
end