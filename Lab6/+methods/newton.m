function [x_sol, y_sol, iter] = newton(f, J, x0, y0, tol, max_iter)
    x_sol = x0;
    y_sol = y0;
    
    for iter = 1:max_iter
        % Вычисление функции и матрицы Якоби
        F_val = f(x_sol, y_sol);
        J_val = J(x_sol, y_sol);
        
        % Решение системы
        delta = -J_val \ F_val;
        
        % Обновление решения
        x_sol = x_sol + delta(1);
        y_sol = y_sol + delta(2);
        
        % Проверка условия сходимости
        if norm(F_val) < tol
            break;
        end
    end
end