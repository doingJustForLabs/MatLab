function [x_extr, f_extr, iter, x_history, f_history] = newton(f, df, ddf, x0, eps, max_iter)
    % Метод Ньютона для поиска экстремума
    iter = 0;
    x = x0;
    x_history = [x];
    f_history = [f(x)];
    
    while iter < max_iter
        iter = iter + 1;
        x_new = x - df(x) / ddf(x);
        
        x_history = [x_history; x_new];
        f_history = [f_history; f(x_new)];
        
        if abs(x_new - x) < eps
            break;
        end
        
        x = x_new;
    end
    
    x_extr = x_new;
    f_extr = f(x_extr);
end