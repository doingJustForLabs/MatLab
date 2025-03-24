% Метод хорд
function [x, iter] = chord(f, a, b, accuracy)
    iter = 0;

    while abs(b - a) > accuracy
        abs(b - a)
        x = a - (f(a) * (b - a)) / (f(b) - f(a))
        iter = iter + 1;
        if f(a) * f(x) > 0
            b = x;
        else
            a = x;
        end
    end
    
    x = (a + b) / 2;
end