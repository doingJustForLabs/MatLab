function [dy_simple, d2y_simple] = simpleFormula(x, y, h) 
    dy_simple = zeros(size(x));
    d2y_simple = zeros(size(x));
    
    for i = 2:length(x)-1
        dy_simple(i) = (y(i+1) - y(i-1)) / (2*h);
        d2y_simple(i) = (y(i+1) - 2*y(i) + y(i-1)) / h^2;
    end
end