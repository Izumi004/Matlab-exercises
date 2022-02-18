function A = laplace0(n, m)
% A = laplace0(n, m)
% MATH3311/MATH5335: File = laplace0.m
% Create sparse matrix arising from 5 point discretization of Laplacian
% in two dimensions with n+1 intervals in x, m+1 intervals in y
%
% If no input arguments are specified, default values are n = 5; m = 8;
% Also try n = 20; m = 40

if nargin ~= 2
   n = 5;
   m = 8;
end

% Total number of variables
mn = m * n;

% Sparse diagonal setup for row ordering of variables
e = ones(mn,1);
em1 = e;
em1([n:n:mn]) = zeros(m,1);
ep1 = e;
ep1([1:n:mn]) = zeros(m,1);
dp = [-n -1 0 1 n];
A = spdiags([-e -em1 4*e -ep1 -e], dp, mn, mn);
A = full(A);