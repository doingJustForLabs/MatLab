function [roots, iter] = sec_method(f, x0, eps_res)
    itermax = 1000;
    iter = 1;
    roots = [];  % Массив для хранения корней на каждой итерации
    f_values = [];
    roots(1) = x0;
    
    h = 1e-6;
    df = (f(x0 + h) - f(x0)) / h;
    x1=x0-f(x0)/df;
    f_values(1) = f(x1);
    % if (f(x0)*f(x1) > 0)
    %     error("Значения x0 и x1 должны удовлетворять условию " + ...
    %         "f(x0)*f(x1) < 0")
    % end

    while abs(x1-x0) > eps_res && iter < itermax
        x2 = x1 - f(x1) * (x1 - x0)/(f(x1) - f(x0));
        iter = iter + 1;
        roots(iter) = x2;
        f_values(iter) = f(x2);

        % Проверка сходимости
        if abs(x2 - x1) < eps_res
            break;
        end

        x0=x1; 
        x1=x2;
    end
    figure;
    fplot(f, [1.4, 1.6]);
    hold on;
    ylim([-10, 30]);
    plot(roots, f_values, 'r*-');
    plot(roots(1), f(x0), 'go');  % Начальная точка
    plot(roots(iter), f(roots(iter)), 'bo');  % Найденный корень
    xlabel('x');
    ylabel('f(x)');
    title('Метод хорд: сходимость');
    grid on;
end

