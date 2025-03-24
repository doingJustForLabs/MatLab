% Метод касательных
function [x, iter] = newton(f, df, x0, accuracy)
    x1 = x0 - f(x0) / df(x0);
    iter = 1;

    while abs(x1 - x0) > accuracy && abs(f(x0)) > accuracy
        x0 = x1;
        iter = iter + 1;
        x1 = x0 - f(x0) / df(x0);
    end
    x = x1;
end