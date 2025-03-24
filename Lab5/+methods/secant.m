% Метод секущих
function [x, iter] = secant(f, x0, x1, accuracy)
    iter = 0;
    
    while abs(x1 - x0) > accuracy && abs(f(x1)) > accuracy
        iter = iter + 1;
        x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));
        x0 = x1;
        x1 = x2;
    end
    
    x = x1;
end