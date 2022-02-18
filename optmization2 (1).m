Covariance_matrix = .2*[465 - 0.2*45*45, 287 - 0.2*45*35, 565 - 0.2*45*50;
                         287 - 0.2*35*45, 259 - 0.2*35*35, 290 - 0.2*35*50;
                         565 - 0.2*45*50, 290 - 0.2*35*50, 776 - 0.2*50*50]; %3x3 covariance matrix 
H = 2*Covariance_matrix; %converting covariance matrix into standard form
E = [9, 7, 10]; %expected return per dollar for each portfolio
A = [-0.09 -0.07 -0.10;
     1 1 1]; %inequality constraint matrix
b = [-800 10000];
Aeq = [];
beq = [];
lb = [0 0 0]; %non negativity condition
ub = [];

quadprog(H, [0 0 0], A, b, Aeq, beq, lb, ub)

        