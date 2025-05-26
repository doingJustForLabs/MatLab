function [x, y] = euler(f, interval, y0, h)
    a = interval(1);
    b = interval(2);
    x = a:h:b;
    n = length(x);
    y = zeros(1, n);
    y(1) = y0;

    for i = 1:(n-1)
        y(i+1) = y(i) + h * f(x(i), y(i));
    end
end