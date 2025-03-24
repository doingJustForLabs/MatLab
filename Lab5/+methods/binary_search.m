% Метод половинного деления
function [x, iter] = binary_search(f, a, b, accuracy)
    if f(a) * f(b) >= 0
        error('Функция не меняет знак на заданном интервале.');
    end

    iter = 0;

    while (b - a) > accuracy
        c = (b + a) / 2; 
        iter = iter + 1; 
        if f(c) == 0

            return; 
        elseif f(a) * f(c) < 0
            b = c; 
        else
            a = c; 
        end
    end

    x = (a + b) / 2; 
end