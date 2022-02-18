% MATH3311/MATH5335: ex05check.m
%
% This program checks the answers of Exercises 4 on data fitting



function ex05q1check

clear

load wm1.dat
wm1sol = wm1;

clear wm1;

format compact
format long e

delete ex05q1report.txt


diary on


% List student submission
if exist('ex05q1.m', 'file')==2
    fprintf('\n========== File ex05q1.m ========\n')
    type ex05q1.m
    try
        fprintf('\n\n\n---------- Running ex05q1.m --------\n')
        ex05q1
    catch MSG
        fprintf('ERROR running ex05q1.m:\n');
        MSG.message
        %quit
    end
else
    fprintf('\n ======== No file ex05q1.m in current folder =======\n');
    %quit
end;




fprintf('\n\n\n');
fprintf('================ ex05q1 checking program ============\n\n\n');





%% Reconstruct sparse matrix

% Data stored as row index i, column index j, value A(i,j)
Isol = wm1sol(:,1);
Jsol = wm1sol(:,2);
Vsol = wm1sol(:,3);
Asol = sparse(Isol, Jsol, Vsol)';

[msol, nsol] = size(Asol);


if exist('Asol', 'var') == 1
    fprintf('1) a) Matrix A exists and |A-Asol| = %f\n', norm(A-Asol,1) )
    if norm(A-Asol,1) < msol*nsol*eps
        fprintf('1) a) Answer correct\n');
    else
        fprintf('1) a) Answer not correct\n');
    end;
else
    fprintf('1) a) Matrix A is not defined\n')
end;




%% Plot non-zero elements

figure(1)
spy(A)
title('Matrix Market example on world economic regions')

% Sparsity as a percentage
Asp = 100*nnz(A)/numel(A)

%% Form B = A'*A

B = A'*A;
figure(2)
spy(B)
title('B = A^T A')
% B as a lot more non-zero elements than A, an example of fill-in
Bsp = 100*nnz(B)/numel(B)

figure(3)
subplot(2,3,1)
spy(B)
title('B = A^T A')
R0 = chol(B);
subplot(2,3,4);
spy(R0)
title('Cholesky factor of B')
R1sp = 100*nnz(R0)/numel(R0)

%% SYMRCM reordering

% Reorder rows and columns while preserving symmetry and reducing fill-in
% The symrcm re-ordering tries to move non-zero elements close to diagonal
% and hence reduce the fill-in when calculating the Cholesky factor
p = symrcm(B);
% To preserve symmetry the same re-ordering must be applied to rows and columns
B1 = B(p,p);
R1 = chol(B1);
subplot(2,3,2)
spy(B1)
title('B(p,p), p = symrcm(B)')
subplot(2,3,5)
spy(R1)
title('Cholesky factor of B(p,p)')

%% SYMAMD reordering

% The adaptive minimum degree algorithm tries to reduce the fill-in
% that occurs when factorizing a symmetric positive definite matrix
% so its Cholesky factor is sparser
q = symamd(B);
B2 = B(q,q);
R2 = chol(B2);
subplot(2,3,3)
spy(B2)
title('B(q,q), q = symamd(B)')
subplot(2,3,6)
spy(R2)
title('Cholesky factor of B(q,q)')

%% QR factorization

% Full QR factorization of m by n A gives
% Q = m by m orthogonal and RF = m by n upper triangular
[Q, RF] = qr(A);
R = RF(1:n,1:n);
% Economy QR factorization of m by n A gives
% Y = m by n orthogonal and R = n by n upper triangular
%[Y, R] = qr(A, 0);
figure(4)
subplot(1,2,1)
spy(Q)
title('QR factorization: Q')
subplot(1,2,2)
spy(RF)
title('QR factorization: R')

%% Relation to Cholesky

% Check relation with R0 from Cholesky factorization
Rdiff = norm(R-R0, 1)
BAdiff = norm(B-R'*R, 1)
R1dm = min(diag(R0))
Rdm = min(diag(R))

% You can change the sign of a column of an orthogonal matrix
% without affecting the fact that is orthogonal
% This would change the sign of the corresponding row of the
% upper triangular matrix R
% Thus you could make all the diagonal elements of R positive
% as is the case with the R from the Cholesky factorization





fprintf('Note that not all parts of the tutorial exercises can be marked by this program.\n\n');


diary ex05q1report.txt


diary off


clear

{"mode":"full","isActive":false}