%7

figure;

subplot(2, 2, 1);        % первый график из 4 на одном окне (первые 2 - кол-во подграфиков, последнее - номер графика)
x = linspace(-4,4,1000); % последнее значение - кол-во точек, по которым строится график
y = x.^3 - x;
plot(x,y);
title('y(x)=x^3-x');

subplot(2, 2, 2);
x = linspace(-2, 2, 500);
y = sin(1./x.^2);
plot(x,y);
title('y(x)=sin(1/x^2)');

subplot(2, 2, 3);
ezplot(@(x) tan(x./2)', [-pi, pi]);
title('Y = tan(x/2)');
axis([-pi pi -10 10]);

subplot(2, 2, 4);
ezplot('e^((-x^2)/2)', [-1.5, 1.5]);
hold on;                   % для построения на одной и той же координатной сетке
ezplot('x^4-x^2');
title('y(x) = e^{-x^2/2} и y(x) = x^4 - x^2');
legend('e^{-x^2/2}', 'x^4-x^2');    % add legends to axes

for i = 1:4
    subplot(2, 2, i);
    xlabel('x');
    ylabel('y');
    grid on;          % grid добавляет сетку к текущему графику
end