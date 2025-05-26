function [x_min, f_min, iter, x_history, f_history] = goldenSection(f, a, b, eps)
    % Метод золотого сечения для поиска минимума
    phi = (1 + sqrt(5)) / 2;
    iter = 0;
    x_history = [];
    f_history = [];
    
    while abs(b - a) > eps
        iter = iter + 1;
        x1 = b - (b - a) / phi;
        x2 = a + (b - a) / phi;
        
        if f(x1) < f(x2)
            b = x2;
        else
            a = x1;
        end
        
        x_history = [x_history; (a + b)/2];
        f_history = [f_history; f((a + b)/2)];
    end
    
    x_min = (a + b) / 2;
    f_min = f(x_min);
end
