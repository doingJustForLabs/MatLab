function [dy_many, d2y_many] = multipointFormula(x, y, h) 
    dy_many = zeros(size(x));
    d2y_many = zeros(size(x));
    
    for i = 3:length(x)-2
        dy_many(i) = (-y(i+2) + 8*y(i+1) - 8*y(i-1) + y(i-2)) / (12*h);
        d2y_many(i) = (-y(i+2) + 16*y(i+1) - 30*y(i) + 16*y(i-1) - y(i-2)) / (12*h^2);
    end
end