clear;
clc;

x = -3.59;
y = 0.467;
z = 563.2;
f = x * sin(y) + z^(1/3);

Dx = 0.01;
Dy = 0.001;
Dz = 0.1;

dx = Dx / x;
dy = Dy / y;
dz = Dz / z;

% Относительная погрешность
df = abs(sin(y)) * dx + abs(x * cos(y)) * dy + abs(z^-(2/3) / 3) * dz

% Абсолютная погрешность
Df = df * f