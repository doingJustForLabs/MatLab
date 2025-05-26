function [h, trap_result] = trapezoid_method(f, a, b, accuracy)
    M2 = 1;  % Максимальное значение второй производной |sin(x)| = 1
    h = sqrt(12 * accuracy / ((b - a) * M2));  % Максимальный шаг

    fprintf('Максимальный шаг h для метода трапеций: %.4f\n\n', h);
    
    n = ceil((b - a) / h);     % количество шагов
    x = linspace(a, b, n+1);   % Узлы сетки
    y = f(x);                  % Значения функции

    trap_result = (b - a) / (2*n) * (y(1) + 2*sum(y(2:end-1)) + y(end));
end