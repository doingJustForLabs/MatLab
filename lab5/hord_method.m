function [root, iter] = hord_method(f, a, b, eps)
    itermax = 150000;
    iter = 1;
    roots = [];
    f_values = [];

    % Проверка на начальные условия
    if f(a) * f(b) >= 0
        error('Значения функции на концах интервала должны иметь противоположные знаки.');
    end

    % Начальная итерация
    c = a - f(a) * (b - a) / (f(b) - f(a));
    roots(iter) = c;
    f_values(iter) = f(c);

    while abs(b - a) >= eps && iter < itermax
        iter = iter + 1;
        
        c = a - f(a) * (b - a) / (f(b) - f(a));
        
        roots(iter) = c;
        f_values(iter) = f(c);
        
        % Проверка сходимости
        if abs(f(c)) < eps
            break;
        end
        
        % Обновляем интервал
        if f(a) * f(c) < 0
            b = c;
        else
            a = c;
        end
    end

    figure;
    fplot(f, [1, 3]);  % График функции
    hold on;
    ylim([-10, 30]);
    plot(roots, f_values, 'r*-');  % Путь к корню
    plot(a, f(a), 'go');   % Начальная точка
    plot(roots(iter), f(roots(iter)), 'bo');  % Найденный корень
    xlabel('x');
    ylabel('f(x)');
    title('Метод хорд: сходимость');
    grid on;
    
    root = roots(iter);
end

