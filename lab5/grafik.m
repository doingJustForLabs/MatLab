% eps_local=0.5;
% eps_end = 1e-10;

f=@(x) (-2*exp(x)+10 - sin(x));

% def f(x):
%     return -2*exp(x)+10 - sin(x);
    

x = linspace(-200, 10, 1000);
y = f(x);

plot(x, y, 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('f(x)');
title('График функции f(x) = -2e^x + 10 - sin(x)');

ax = gca; % Получаем текущие оси
ax.XAxisLocation = 'origin'; % Ось абсцисс проходит через y = 0
ax.YAxisLocation = 'origin';

ylim([-10, 30]);

hold on;
plot(x, zeros(size(x)), 'k--', 'LineWidth', 1.5); % Линия y = 0
legend('f(x)', 'y = 0'); % Легенда
hold off;