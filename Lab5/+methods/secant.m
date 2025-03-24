% Метод секущих
function [x, iter] = secant(f, x0, accuracy)
    iter = 1;
    
    x1 = x0 + 0.1;
    x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));
    
    while abs(x2 - x1) > accuracy
        x0 = x1;
        x1 = x2;
        x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));  
        iter = iter + 1;
    end
    x = x2;
end