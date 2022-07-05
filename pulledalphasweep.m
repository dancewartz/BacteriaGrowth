clear; close all; clc; 
v0 = 1;
s0 = 1;
lambda = 9;

dt = 5; 
dx = 0.5;
T = 200;
t = dt:dt:T;

u0 = 2*sqrt(s0);
alpha_c = u0^2/2/lambda;
alphas = linspace(-4*alpha_c,4*alpha_c,40);
  
for k = 1:length(alphas)
    disp("iteration " + num2str(k));
    alpha = alphas(k);
    [u,~,~] = predict_u_pulled(s0,alpha,lambda);
    L = 1.2*u*T;
    x = -L:dx:L;
    
    params = [v0 s0 alpha lambda];

    pdefun = @(x,t,u,dudx) pdefuntot(x,t,u,dudx,params);
    tic
    sol = pdepe(0,pdefun,@(y) icfun(y),@(xl,ul,xr,ur,t) bcfun(xl,ul,xr,ur,t),x,t);
    toc
    
    par.v0 = v0; par.s0 = s0; par.lambda = lambda; par.dt = dt; par.dx = dx; par.T = T;
    par.L = L; par.alpha = alpha; par.alphas = alphas; par.k = k;
    datapath = "pulledalphasweepdata\pulledalphasweepdata" + num2str(k) + ".mat";
    save(datapath,'par','sol')
end
