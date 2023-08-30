clear; close all; clc;
v0 = 10; par.v0 = v0; % upward velocity, can be whatever
alpha = 0; par.alpha = alpha; % growth rate difference
v = @(f) v0 + alpha*f; % growth velocity function

f0 = 0; par.f0 = f0; % Allee threshold
s0 = 1/2; par.s0 = s0;% selection coefficient

Df = 1; par.Df = Df; % f diffusion
Dh = 1; par.Dh = Dh; % h diffusion

u0 = 2*sqrt(s0*Df)

% u0 = (1-2*f0)*sqrt(s0*Df/2);
% Le = @(x) exp(u0*x).*exp(2*x)./(1+exp(x)).^4;
% kap = integral(@(x) Le(x).*hypergeom([1 u0/Dh],1+u0/Dh,-exp(x)),-150,150)/integral(Le,-150,150);
% par.kap = kap;

[u,u0,circ] = predict_u(par);

T = 100; % total time
dt = 0.1; % NOT TIME STEP, JUST WHEN SOLUTION IS GIVEN
t = dt:dt:T; par.t = t;% time vector

L = max(abs(u)*T,50); % system size
dx = 0.3; % space step
if u > 0
    x = -L/2:dx:1.1*L; % biased grid for efficiency
else
    x = -1.1*L:dx:L/2; % biased grid for efficiency
end
par.x = x;


alpha_c = u0^2/v0/2;