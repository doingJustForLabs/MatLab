function [x_min, f_min, iter, x_history, f_history] = parabolic(f, x1, x2, x3, eps, max_iter)
    % Метод парабол для поиска минимума
    iter = 0;
    x_history = [];
    f_history = [];
    
    while iter < max_iter
        iter = iter + 1;
        
        A = [(x2^2 - x3^2)*f(x1) + (x3^2 - x1^2)*f(x2) + (x1^2 - x2^2)*f(x3);
             (x3 - x2)*f(x1) + (x1 - x3)*f(x2) + (x2 - x1)*f(x3)] / ...
            ((x1 - x2)*(x1 - x3)*(x2 - x3));
        
        % Вершина параболы
        x_new = -A(2)/(2*A(1));
        
        x_history = [x_history; x_new];
        f_history = [f_history; f(x_new)];
        
        if iter > 1 && abs(x_new - x_history(end-1)) < eps
            break;
        end
        
        if x_new > x2
            if f(x_new) < f(x2)
                x1 = x2;
                x2 = x_new;
            else
                x3 = x_new;
            end
        else
            if f(x_new) < f(x2)
                x3 = x2;
                x2 = x_new;
            else
                x1 = x_new;
            end
        end
        
        if x_new < min([x1, x2, x3]) || x_new > max([x1, x2, x3])
            warning('Параболическая аппроксимация вышла за границы интервала');
            break;
        end
    end
    
    [f_min, idx] = min(f_history);
    x_min = x_history(idx);
end