clc;

A = [6 -1 1; 
    1 -2 3; 
    3 4 4];

B = [0; 1; -1];

det_A = det(A);
rank_A = rank(A);
norm_A = norm(A);

cond_A = cond(A);

X_obratn_matrix = inv(A)*B;
X_linsolve = linsolve(A, B);

accuracy_check = (A * X_obratn_matrix - B);

fprintf("Coeffitients matrix:\nDet: %.3f\nRank: %d\nNorm: %.3f\n\n", ...
    det_A, rank_A, norm_A);

fprintf('By inv matrix:\n');
fprintf('%10.5f\n', X_obratn_matrix);

fprintf('\nlinsolve:\n');
fprintf('%10.5f\n', X_linsolve);

fprintf('\n %.5f\n\n', cond_A);

fprintf('Accuracy\n');
fprintf('%14.5e\n', accuracy_check);