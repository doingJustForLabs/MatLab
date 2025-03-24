% Метод хорд
function [x, iter] = chord(f, x0, a, b, accuracy)
    x1 = x0 - f(x0) / (f(b) - f(x0)) * (b - x0);    
    iter = 1;
    
    while abs(x1 - x0) >= accuracy
        x0 = x1;
        iter = iter + 1;
        x1 = x0 - f(x0) / (f(b) - f(x0)) * (b - x0);  
    end
    
    x = x1;
end