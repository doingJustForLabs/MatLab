clear;
clc;

% Вариант 25

x0 = 3.72;
steps = [10, 20, 50, 100, 200];  % разные количества узлов
N = length(steps);

% Предварительное выделение памяти
point_err_dy_simple = zeros(1, N);
point_err_dy_many = zeros(1, N);
point_err_d2y_simple = zeros(1, N);
point_err_d2y_many = zeros(1, N);
step_sizes = zeros(1, N);

for idx = 1:N
    n = steps(idx);
    x = linspace(0, 2*pi, n); % равномерная сетка
    y = sin(x) + 0.3*x; % функция
    h = x(2) - x(1); % шаг

    [dy_simple, d2y_simple] = methods.simpleFormula(x, y, h);
    [dy_many, d2y_many] = methods.multipointFormula(x, y, h);         

    % Аналитические производные
    dy_exact = cos(x) + 0.3;
    d2y_exact = -sin(x);

    % Абсолютные ошибки
    err_dy_simple = abs(dy_simple - dy_exact);
    err_dy_many = abs(dy_many - dy_exact);
    err_d2y_simple = abs(d2y_simple - d2y_exact);
    err_d2y_many = abs(d2y_many - d2y_exact);

    % Индекс ближайшей к x0 точки
    [~, ix] = min(abs(x - x0));

    % Ошибки в точке x0
    point_err_dy_simple(idx) = err_dy_simple(ix);
    point_err_dy_many(idx) = err_dy_many(ix);
    point_err_d2y_simple(idx) = err_d2y_simple(ix);
    point_err_d2y_many(idx) = err_d2y_many(ix);
    step_sizes(idx) = h;

    % Графики на фиксированной сетке
    if n == 100
        figure('Position', [100, 100, 900, 600]);
        
        subplot(2,2,1);
        plot(x, dy_exact, 'k-', x, dy_simple, 'r--', x, dy_many, 'b-.');
        legend('dy точная','Простая','5-точечная');
        title('Первая производная');
        xlabel('x'); ylabel('dy');

        subplot(2,2,2);
        plot(x, d2y_exact, 'k-', x, d2y_simple, 'r--', x, d2y_many, 'b-.');
        legend('d2y точная','Простая','5-точечная');
        title('Вторая производная');
        xlabel('x'); ylabel('d²y');

        subplot(2,2,3);
        plot(x, err_dy_simple, 'r--', x, err_dy_many, 'b-.');
        legend('Простая','5-точечная');
        title('Погрешность первой производной');
        xlabel('x'); ylabel('Ошибка');

        subplot(2,2,4);
        plot(x, err_d2y_simple, 'r--', x, err_d2y_many, 'b-.');
        legend('Простая','5-точечная');
        title('Погрешность второй производной');
        xlabel('x'); ylabel('Ошибка');
    end
end

% Графики зависимости ошибки в x0 от шага
figure('Position', [200, 200, 800, 600]);

subplot(2,1,1);
plot(step_sizes, point_err_dy_simple, 'r-o', ...
     step_sizes, point_err_dy_many, 'b-s');
legend('Простая','5-точечная');
title('Ошибка первой производной в x_0 в зависимости от шага');
xlabel('Шаг h'); ylabel('Ошибка');
grid on;

subplot(2,1,2);
plot(step_sizes, point_err_d2y_simple, 'r-o', ...
     step_sizes, point_err_d2y_many, 'b-s');
legend('Простая','5-точечная');
title('Ошибка второй производной в x_0 в зависимости от шага');
xlabel('Шаг h'); ylabel('Ошибка');
grid on;
