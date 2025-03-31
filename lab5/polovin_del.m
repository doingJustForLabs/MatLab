function [root, iter] = polovin_del(f, a, b, eps)
    itermax = 100;
    iter = 1;
    if f(a) * f(b) >= 0
        error ('На данном нет корня');
    end
    f_values = [];
    root = [];
    while ((b-a)>2*eps)&(iter<itermax)&...
                      (f(a)*f(b)<=0)
        x2=0.5*(a+b);
        f_values(iter) = f(x2);
        root(iter)=x2;
        if f(a)*f(x2)<=0
            b=x2;
        end
        if f(x2)*f(b)<=0
            a=x2;
        end   
        iter=iter+1;
    end
    root(iter) = 0.5 * (a + b);
    f_values(iter) = f(root(iter));

    figure;
    fplot(f, [-10, 10]);
    hold on;
    ylim([-10, 30]);
    
    plot(root, f_values, 'r*-'); 
    
    % начальная и конечная точки
    plot(root(1), f(root(1)), 'go');   % Начальная точка
    plot(root(iter), f(root(iter)), 'bo');  % Найденный корень
    
    xlabel('Итерации');
    ylabel('Значение функции f(x)');
    title('Метод дихотомии: сходимость');
    grid on;
end