function [c,f,s] = pdefuntot(x,t,u,dudx,params)
v0 = params(1);
s0 = params(2);
alpha = params(3);
lambda = params(4);

c = [1; 1];
f = [dudx(1); dudx(2)];
s = [s0*u(1)*(1-u(1)) + lambda*dudx(1)*dudx(2); v0 + alpha*u(1) + lambda/2*dudx(2)^2];
end