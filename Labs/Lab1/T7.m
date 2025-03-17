clear;
clc;

%a)
x = linspace(-4, 4);
plot(x, x.^3 - x);
title("y = x^3 - x")
grid
xlabel("x")
ylabel("y")

%b)
ezplot('sin(1/x^2)', [-2, 2]);
title("y = sin(1/x^2)")
grid
xlabel("x")
ylabel("y")

%c)
x = -1.5:0.1:1.5;
y1 = exp(-x.^2 / 2);
y2 = x.^4 - x.^2;
plot(x, y1, x, y2);
title("y1 = exp(-x^2 / 2); y2 = x^4 - x^2")
legend("y1", "y2")
grid
xlabel("x")
ylabel("y")

%d)
ezplot('tan(x / 2)');
axis([-pi, pi, -10, 10]);
title("y = tan(x / 2)")
grid
xlabel("x")
ylabel("y")