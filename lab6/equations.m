function F = equations(vars)
    x = vars(1);
    y = vars(2);

    % Система уравнений:
    F = [
        y^3 + 3*sin(x)*cos(x) - 2;
        2*y - (3*x + sin(x) - 5)
    ];
end