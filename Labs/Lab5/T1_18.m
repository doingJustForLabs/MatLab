clc;

f = @(x) (x-2).^2 - 11 - (5.^x) + 3;

function intervals = brude_loc(f, a, b, h)

    intervals = [];
    x = a:h:b;
    for i = 1:length(x)-1
        if f(x(i)) * f(x(i+1)) < 0
            intervals = [intervals; [x(i), x(i+1)]];
        end
    end
    
    if isempty(intervals)
        disp('Корни не найдены.');
        return;
    else
        return;
    end
end

function root = simple_iteration(g, x0, accuracy)
    x = x0;
    max_iter = 100000;
    for iter = 1:max_iter
        x_new = g(x);
        if abs(x_new - x) < accuracy
            root = x_new;
            fprintf('МПИ: %d итераций: x = %.6f\n', iter, root);
            return;
        end
        x = x_new;
    end
end

function root = chord_method(f, a, b, accuracy)
    max_iter = 10000;

    for iter = 1:max_iter

        c = a - (f(a) * (b - a)) / (f(b) - f(a));

        if abs(f(c)) < accuracy
            root = c;
            fprintf('МХ: %d итераций: x = %.6f\n', iter, root);
            return;
        end

        if f(a) * f(c) < 0
            b = c;
        else
            a = c;
        end
    end
end

function root = newton_method(f, x0, accuracy)
    max_iter = 10000;
    x = x0;
    df = diff(f);
    

    for iter = 1:max_iter
        fx = f(x);
        dfx = df(x);
        x_new = x - fx / dfx;

        if abs(x_new - x) < accuracy || abs(f(x_new)) < accuracy
            root = x_new;
            fprintf('МН: %d итераций: x = %.6f\n', iter, root);
            return;
        end

        x = x_new;
    end
end

x = linspace(-20, 20, 100);
y = f(x); 
plot(x, y);
hold on;

xline(0, 'k--', 'LineWidth', 1); 
yline(0, 'k--', 'LineWidth', 1);
axis equal;

xlim([-20, 20]);
ylim([-20, 20]);
xlabel('x');
ylabel('f(x)');
title('f(x) = (x-2)^3 - 11 - 5^x + 3');
grid on;

hold off;

% Перебором находим приближённое значение.

a = -1;
b = 0;
h = 0.2;

intervals = brude_loc(f, a, b, h);

% Метод простых итераций.

accuracy = 1e-10;

x_iter_form = @(x) (x.^2 + 4 - 11 - 5.^x + 3)/4;

roots_sim = [];

for i = 1:length(intervals)-1
   x0 = intervals(i);
   root = simple_iteration(x_iter_form, x0, accuracy);
   if (root)
       roots_sim = [roots, root];
   end
end

% Метод хорд

roots_chord = [];

for i = 1:length(intervals)-1
   a = intervals(i);
   b = intervals(i+1);
   root = chord_method(f, a, b, accuracy);
   if (root)
       roots_chord = [roots_chord, root];
   end
end

% Метод Ньютона

roots_newton = [];

for i = 1:length(intervals)-1
   x0 = intervals(i);
   root = newton_method(f, x0, accuracy);
   if (root)
       roots_newton = [roots_newton, root];
   end
end