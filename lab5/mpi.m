function [root, iter] = mpi(f, x0, eps_res, g)
    itermax= 1000;
    iter = 1;
    % Начальные значения
    x1 = g(x0); 
    x2 = g(x1);

    root(1) = x0; 
    root(2) = x1; 
    root(3) = x2;
    % iter=4;
    f_values = [f(x0), f(x1), f(x2)];

    % Цикл итераций
    while abs(x2 - x1) > eps_res && iter < itermax
        x0 = x1; 
        x1 = x2; 
        x2 = g(x1);
        
        iter = iter + 1;
        root(iter + 2) = x2;  % Добавляем новый корень для текущей итерации
        f_values(iter + 2) = f(x2);
        % fprintf('Итерация %d: %.10f\n', iter, x2);
    end

    % Если сходимость достигнута, выводим результат
    if abs(x2 - x1) <= eps_res
        root_final = x2;  % Окончательное значение корня
        % disp('Метод МПИ сошелся');
        disp(['Корень: ', num2str(root_final)]);
    else
        % Если метод не сошелся, выбрасываем ошибку
        error('Метод простых итераций не сошелся за %d итераций.', itermax);
    end

    % % Рисуем траекторию сходимости
    % figure;
    % plot(1:iter,root,'-*');
    % xlabel('Итерации');
    % ylabel('Значение корня');
    % title('Метод простых итераций: сходимость');
    % grid on;
    figure;
    fplot(f, [-1, 2]);
    hold on;
    ylim([-10, 30]);
    plot(root, f_values, 'r*-');  % Значения функции на каждом шаге
    plot(x0, f(x0), 'go');  % Начальная точка
    plot(root(iter), f(root(iter)), 'bo');  % Найденный корень
    xlabel('Итерации');
    ylabel('Значение функции f(x)');
    title('Метод МПИ: сходимость');
    grid on;
end
