clear;
clc;
 
% Вариант 25

% x = 3.72

steps = [10, 20, 50, 100, 200, 500];  % разные шаги
max_err_dy_simple = [];
max_err_dy_many = [];
max_err_d2y_simple = [];
max_err_d2y_many = [];

for idx = 1:length(steps)
    n = steps(idx);
    x = linspace(0, 2*pi, n);    % равномерные точки
    y = sin(x) + 0.3*x;          % функция
    h = x(2) - x(1);             % шаг

    % Простые формулы (центр. разности)
    [dy_simple, d2y_simple] = methods.simpleFormula(x, y, h);

    % Многоточечные формулы (5-точечные)
    [dy_many, d2y_many] = methods.multipointFormula(x, y, h);

    % Точные значения производных
    dy_exact = cos(x) + 0.3;
    d2y_exact = -sin(x);

    % --- ОШИБКИ ---
    err_dy_simple = abs(dy_simple - dy_exact);
    err_dy_many = abs(dy_many - dy_exact);
    err_d2y_simple = abs(d2y_simple - d2y_exact);
    err_d2y_many = abs(d2y_many - d2y_exact);

    % --- Графики ---
    if n == 20  
        figure;
        set(gcf, 'Position', [100, 100, 800, 600]); 
        subplot(2,2,1);
        plot(x, dy_exact, 'k-', x, dy_simple, 'r--', x, dy_many, 'b-.');
        legend('dy','Simple','5-point');
        title('Первая производная');
        
        subplot(2,2,2);
        plot(x, d2y_exact, 'k-', x, d2y_simple, 'r--', x, d2y_many, 'b-.');
        legend('d2y','Simple','5-point');
        title('Вторая производная');

        subplot(2,2,3);
        plot(x, err_dy_simple, 'r--', x, err_dy_many, 'b-.');
        legend('Simple','5-point');
        title('Ошибка первой производной');

        subplot(2,2,4);
        plot(x, err_d2y_simple, 'r--', x, err_d2y_many, 'b-.');
        legend('Simple','5-point');
        title('Ошибка второй производной');
    end
end