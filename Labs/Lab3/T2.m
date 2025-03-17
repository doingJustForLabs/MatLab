clc;

A = [9.1 5.6 7.8; 
    3.8 5.1 2.8; 
    4.1 5.7 1.2];

B = [9.8; 6.7; 5.8];

det_A = det(A);
rank_A = rank(A);
norm_A = norm(A);

cond_A = cond(A);

X_Gauss = A\B;
X_linsolve = linsolve(A, B);

accuracy_check = (A * X_Gauss - B);

fprintf("Coefficients matrix:\nDet: %.3f\nRank: %d\nNorm: %.3f\n\n", ...
    det_A, rank_A, norm_A);
fprintf('Gauss:\n');
fprintf('%10.5f\n', X_Gauss);
fprintf('linsolve:\n');
fprintf('%10.5f\n', X_linsolve);
fprintf('\nConditionality of the matrix %.5f\n\n', cond_A);
fprintf('Accuracy\n');
fprintf('%14.5e\n', accuracy_check);
