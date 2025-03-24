% Метод простых итераций
function [x, iter] = simple_iterations(f, df, x0, accuracy)
    gamma = 1;
    v = 0.7;
    
    if df(x0) < 0
        sign = -1;
    else
        sign = 1;
    end
    
    lam = - (sign * v) / (gamma + abs(df(x0)));

    x1 = x0 + lam * f(x0);
    iter = 1;

    while abs(x1 - x0) > accuracy
        x0 = x1;
        iter = iter + 1;
        x1 = x0 + lam * f(x0);
    end

    x = x1;
    return 
end