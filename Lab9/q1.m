clear;
clc;

x = [3.37;	5.84;	8.08;	9.83;	11.76;	12.15;	12.81;	13.25;	14.53];
y = [1.427;	13.471;	17.644;	42.907;	63.659;	71.609;	84.174;	98.402;	139.199];
p = [0.9; 0.2; 0.9; 0.7; 1; 0.7; 0.5; 0.9; 0.2];

model = @(params, x) params(1)*exp(params(2)*x) + params(3)*log(x);
error_func = @(params) sum(p .* (model(params, x) - y).^2);

initial_guess = [1, 0.1, 1];
optimal_params = fminsearch(error_func, initial_guess);

a = optimal_params(1);
b = optimal_params(2);
c = optimal_params(3);

% Ищем производные 
df = @(x) a * b * exp(b * x) + c ./ x;
d2f = @(x) a * b^2 * exp(b * x) - c ./ (x.^2);
d5f = @(x) a * b^5 * exp(b * x) + 24 * c ./ x.^5; % n + 1
d6f = @(x) a * b^6 * exp(b * x) - 120 * c ./ x.^6; % n + 2

x12 = (x(1) + x(2)) / 2;
x89 = (x(8) + x(9)) / 2;

fprintf("x12 = %.4f\n", x12);
fprintf("f'(x12) = %.4f, f''(x12) = %.4f\n", df(x12), d2f(x12));
fprintf("x89 = %.4f\n", x89);
fprintf("f'(x89) = %.4f, f''(x89) = %.4f\n", df(x89), d2f(x89));

xi = x(1:5);
n = 4;
i = 2; 
h = mean(diff(xi));

error_estimate = abs((-1)^(n - i) * factorial(i) * factorial(n - i) / factorial(n + 1) * h^n * d5f(x12));
fprintf("Оценка погрешности f'(x12): %.6f\n", error_estimate);

% Вычисляем P5(x) и его производную
P5 = @(x) prod(x - xi);  % Π_5(x)
dP5 = @(x) sum(arrayfun(@(k) prod(x - xi([1:k-1, k+1:end])), 1:length(xi)));  % производная

% Значения в x12
P5_val = P5(x12);
dP5_val = dP5(x12);

% Погрешность по формуле (13.28)
error13_28 = (d5f(x12)/factorial(5)) * dP5_val + (d6f(x12)/factorial(6)) * P5_val;
fprintf("Погрешность по формуле (13.28) в точке x12 = %.4f\n", error13_28);

x_lin = linspace(min(x), max(x), 300);
yy = model(optimal_params, x_lin);

% Строим графики
methods.mainGraphic(x, y, x_lin, yy);
methods.dfGraphic(x_lin, df, d2f);
