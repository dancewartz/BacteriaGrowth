%% ANALYSIS CODE ASSUMING sol, par, v ARE IN MEMORY
close all;
s0 = par.s0;
alpha = par.alpha;
v0 = par.v0;
Df = par.Df;
f0 = par.f0;
x = par.x;
t = par.t;
T = t(end);

f = sol(:,:,1);
h = sol(:,:,2);

%% Get velocity

xind = [];
for q = 1:length(t)
    ind = find(f(q,:)>0.5,1,'last');
    xind(end+1) = x(ind);
end
reg = t > 2*T/3;
p = polyfit(t(reg),xind(reg),1);
u_measured = p(1)