function rel_error = error(x, y, polynomial_coeffs)
    y_polynomial = polyval(polynomial_coeffs, x);
    rel_errors = abs((y - y_polynomial) ./ y);
    rel_error = mean(rel_errors) * 100;    
end