function [c,f,s] = pdefuntot(x,t,u,dudx,par,v)
s0 = par.s0;
alpha = par.alpha;
v0 = par.v0;
Df = par.Df;
Dh = par.Dh;


c = [1; 1];
f = [Df*dudx(1); Dh*dudx(2)];
s = [s0*u(1)*(1-u(1)) + v0*dudx(1)*dudx(2); 1 + alpha*u(1) + v0/2*dudx(2)^2];
end