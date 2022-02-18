% MATH3311/MATH5335: ex05check.m
%
% This program checks the answers of Exercises 4 on data fitting



function ex05q2check

clear

format compact
format long e

delete ex05q2report.txt


diary on


% List student submission
if exist('ex05q2.m', 'file')==2
    fprintf('\n========== File ex05q2.m ========\n')
    type ex05q2.m
    try
        fprintf('\n\n\n---------- Running ex05q2.m --------\n')
        ex05q2
    catch MSG
        fprintf('ERROR running ex05q2.m:\n');
        MSG.message
        %quit
    end
else
    fprintf('\n ======== No file ex05q2.m in current folder =======\n');
    %quit
end




fprintf('\n\n\n');
fprintf('================ ex05q2 checking program ============\n\n\n');


%% (a) 
nsol = 10;


if exist('n', 'var') == 1
    fprintf('2) a) Variable n exists and |n-nsol| = %f\n', norm(n-nsol,1) )
    if norm(n-nsol,1) < nsol*eps
        fprintf('2) a) Answer correct\n');
    else
        fprintf('2) a) Answer not correct\n');
    end
else
    fprintf('2) a) Variable n is not defined\n')
end



%% Create sparse tridiagonal matrix

% Create sparse tridiagonal matrix using spdiags
esol = ones(n,1);
Asol = spdiags([-esol 2*esol -esol], [-1 0 1], nsol, nsol);


if exist('A', 'var') == 1
    fprintf('2) b) Matrix A exists and |A-Asol| = %f\n', norm(A-Asol,1) )
    if norm(A-Asol,1) < nsol*nsol*eps
        fprintf('2) b) Answer correct\n');
    else
        fprintf('2) b) Answer not correct\n');
    end
else
    fprintf('2) b) Matrix A is not defined\n')
end



%% Check symmetry

% A is real symmstrix iff A^T = A  iff  A^T - A = 0  iff || A^T - A || = 0
symchksol = norm(Asol-Asol', 1);

% A is a real symmetric matrix, so the eigenvalues of A must be real
% In fact A is positive definite, so the eigenvalues of A are positive
% However as the size n increases the smallest eigenvalue goes to 0


if exist('symchk', 'var') == 1
    fprintf('2) b) Variable symchk exists and |symchk-symchksol| = %f\n', norm(symchk-symchksol,1) )
    if norm(symchk-symchksol,1) < nsol*eps
        fprintf('2) b) Answer correct\n');
    else
        fprintf('2) b) Answer not correct\n');
    end
else
    fprintf('2) b) Variable symchk is not defined\n')
end



%% Plot non-zero elements

% Spy plot to check it is tridiagonal
% For larger n you need to zoom in to see tridiagonal structure
%figure(1)
%spy(A)
fprintf('2) c) Have you created a spyplot using the Matlab command spy(A)?\n')


%% Eigenvalues

% Calculate eigenvalues of sparse A
% eig ONLY works for full matrices!
evsol = eig(full(Asol));

if exist('ev', 'var') == 1
    fprintf('2) d) i) Vector ev exists and |ev-evsol| = %f\n', norm(ev-evsol,1) )
    if norm(ev-evsol,1) < nsol*eps
        fprintf('2) d) i) Answer correct\n');
    else
        fprintf('2) d) i) Answer not correct\n');
    end
else
    fprintf('2) d) i) Vector ev is not defined\n')
end



% Alternatively use eigs to find k smallest or
% k largest eigenvalues, but need k < n
% Most useful when k is 1, 2 or 3
%k = floor(n/2)
%nk = n-k
%evs = eigs(A, k, 'SA');
%evl = eigs(A, nk, 'LA');
% Put together in increasing order of size
%ev2 = [evs; flipud(evl)];
%evchk = norm(ev-ev2)

% Plot eigenvalues
%figure(2)
%plot(ev, '*');
%grid on
%title('Eigenvalues of tridiagonal A')

fprintf('2) d) ii) Did you plot the eigenvalues in a new window?\n')


evminsol = min(evsol);


if exist('evmin', 'var') == 1
    fprintf('2) d) iii) Variable evmin exists and |evmin-evminsol| = %f\n', norm(evmin-evminsol,1) )
    if norm(evmin-evminsol,1) < nsol*eps
        fprintf('2) d) iii) Answer correct\n');
    else
        fprintf('2) d) iii) Answer not correct\n');
    end
else
    fprintf('2) d) iii) Variable evmin is not defined\n')
end



evmaxsol = max(evsol);


if exist('evmax', 'var') == 1
    fprintf('2) d) iii) Variable evmax exists and |evmax-evmaxsol| = %f\n', norm(evmax-evmaxsol,1) )
    if norm(evmax-evmaxsol,1) < nsol*eps
        fprintf('2) d) iii) Answer correct\n');
    else
        fprintf('2) d) iii) Answer not correct\n');
    end
else
    fprintf('2) d) iii) Variable evmax is not defined\n')
end



% 2-norm condition number
% cond(A) does not work for sparse A
% condest(A) estimates 1-norm condition number of sparse A
evcndsol = evmaxsol/evminsol;
%cndest = condest(A)

if exist('evcnd', 'var') == 1
    fprintf('2) d) iii) Variable evcnd exists and |evcnd-evcndsol| = %f\n', norm(evcnd-evcndsol,1) )
    if norm(evcnd-evcndsol,1) < nsol*eps
        fprintf('2) d) iii) Answer correct\n');
    else
        fprintf('2) d) iii) Answer not correct\n');
    end
else
    fprintf('2) d) iii) Variable evcnd is not defined\n')
end




fprintf('Note that not all parts of the tutorial exercises can be marked by this program.\n\n');


diary ex05q2report.txt


diary off


clear

{"mode":"full","isActive":false}