clear;
clc;


% a
ax_1 = subplot(2, 2, 1);
x = linspace(-4, 4);
plot(x, x.^3 - x);
grid(ax_1,'on');

% b
ax_2 = subplot(2, 2, 2);
ezplot('sin(1/x^2)', [-2, 2]);
grid(ax_2,'on');

% c
ax_3 = subplot(2, 2, 3);
ezplot('tan(x / 2)');
axis([-pi, pi, -10, 10]);
grid(ax_3,'on');


% d
ax_4 = subplot(2, 2, 4);
x = -1.5:0.1:1.5;
y1 = exp(-x.^2 / 2);
y2 = x.^4 - x.^2;
plot(x, y1, x, y2, 'r:');

grid(ax_4,'on');
