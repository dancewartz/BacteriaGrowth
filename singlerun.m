clear; close all; clc;
v0 = 1;
s0 = 1;
alpha = -0.1;
lambda = 9;

params = [v0 s0 alpha lambda];

[u,u0,circ] = predict_u(s0,alpha,lambda);

sigma = -u0/lambda*(1-sqrt(1-2*lambda*alpha/u0^2));

dx = 0.1;
dt = 0.1; 
T = 50;
t = 0:dt:T;
L = 1.2*abs(u)*T;
x = -L:dx:L;

pdefun = @(x,t,u,dudx) pdefuntot(x,t,u,dudx,params);
tic
sol = pdepe(0,pdefun,@(y) icfun(y),@(xl,ul,xr,ur,t) bcfun(xl,ul,xr,ur,t),x,t);
toc

figure
hold on
xlabel('x')
ylabel('h(x,t)')
set(gca,'fontsize',15)

tind = []; xind = [];
for j = 1:length(t)
    fsol = sol(j,:,1);
    hsol = sol(j,:,2);
    active = fsol > 0.5;
    
    plot(x(active),hsol(active),'b.','MarkerSize',10)
    plot(x(~active),hsol(~active),'r.','MarkerSize',10)
    
    ind = find(fsol > 0.5,1,'last');
    tind(end+1) = t(j);
    xind(end+1) = x(ind);
end

fsol = sol(end,:,1);
hsol = sol(end,:,2);
active = fsol > 0.5;

plot(x(active),hsol(active),'b.','MarkerSize',10)
plot(x(~active),hsol(~active),'r.','MarkerSize',10)

p = polyfit(tind(tind>T/2),xind(tind>T/2),1);
u_measured = p(1)

ylim([0 max(hsol)+1])
xlim([-L L])

v_circ = -(lambda+alpha)*sigma;

reg = x > 0 & x < v_circ*T;
reg2 = x > v_circ*T & x < xind(end);

% if u_measured > 0
%     plot(x,v0*T + v0/u*(x-xind(end)),'--','LineWidth',3)
%     plot(x(reg2),v0*T + sigma*(x(reg2)-xind(end)),'--','LineWidth',3)
%     plot(x(reg),(v0+alpha)*T - x(reg).^2/(2*(lambda+alpha)*T),'--','LineWidth',3)
% else
%     plot(x,(v0+alpha)*T + (v0+alpha)/u*(x-xind(end)),'r--','LineWidth',3)
% end

set(gca,'xtick',[])
set(gca,'ytick',[])
xlabel('')
ylabel('')
title('')
set(gca,'LooseInset',get(gca,'TightInset'))