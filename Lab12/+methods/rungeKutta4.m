function [x, y] = rungeKutta4(f, interval, y0, h)
    a = interval(1);
    b = interval(2);
    x = a:h:b;
    n = length(x);
    y = zeros(1, n);
    y(1) = y0;

    for i = 1:(n-1)
        k1 = f(x(i), y(i));
        k2 = f(x(i) + h/2, y(i) + h/2 * k1);
        k3 = f(x(i) + h/2, y(i) + h/2 * k2);
        k4 = f(x(i) + h, y(i) + h * k3);
        y(i+1) = y(i) + (h/6) * (k1 + 2*k2 + 2*k3 + k4);
    end
end