function [root, iter] = newton_method(f, df, x0, eps_res)
    itermax = 1000;
    iter = 1;
    roots = [];  % Массив для хранения корней на каждой итерации
    roots(1) = x0;

    while iter <= itermax
        x1 = x0 - f(x0) / df(x0);
        
        roots(iter+1) = x1;

        % Сходимость?
        if abs(x1-x0) < eps_res
            root = x1;
            iter = iter + 1;
            break;
        end

        x0 = x1;
        iter = iter + 1;
    end

    if iter > itermax
        error('Метод не сошелся за %d итераций.', itermax);
    end

    figure;
    fplot(f, [-1, 2]);  % Задаём область отображения графика функции
    hold on;
    ylim([-10, 30]);
    plot(roots(1:iter), f(roots(1:iter)), 'r*-');  % Траектория сходимости
    plot(roots(1), f(roots(1)), 'go');  % Начальная точка
    plot(root, f(root), 'bo');  % Финальный найденный корень
    xlabel('x');
    ylabel('f(x)');
    title('Метод касательных: сходимость');
    grid on;
end

