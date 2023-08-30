clear; close all; clc;
us = NaN*ones(10); 


for filecount = 1:100
    load("datanew\data" + num2str(filecount) + ".mat")
    get_u;
    us(f0ind,alphaind) = u_measured;
    alphas(f0ind,alphaind) = alpha;
    f0s(f0ind,alphaind) = f0;
    u0s = 1-2*f0s;
    kaps(f0ind,alphaind) = kap;
end
figure
hold on
set(gca,'fontsize',20,'LineWidth',1)
xlabel('$\alpha$','Interpreter','Latex')
ylabel('$u/u_0$','Interpreter','Latex')
% legend('location','southeast')

for k = 1:10
    p = polyfit(alphas(k,:)*v0./(u0s(k,:)),us(k,:),1);
    kaps_measured(k) = p(1);
    plot(alphas(k,:)*v0./(u0s(k,:)),us(k,:),'.','Markersize',15,'DisplayName',"$f_0 = $" + num2str(f0s(k,1)))
    plot(alphas(k,:)*v0./(u0s(k,:)),polyval(p,alphas(k,:)*v0./(u0s(k,:))),'--','LineWidth',2)
end
saveas(gca,'Figures\uvsalpha.png')

f0sth = linspace(-0.5,0.5,20);
joke = 1;
for jj = 1:length(f0sth)
    u0 = 1-2*f0sth(jj);
    Le = @(x) exp(u0*x).*exp(2*x)./(1+exp(x)).^4;
    kaps_theo(jj) = integral(@(x) Le(x).*hypergeom([1 u0/joke],1+u0/joke,-exp(x)),-100,100)/integral(Le,-100,100);
end

figure
hold on
set(gca,'fontsize',15,'LineWidth',2)
% title("v_0=" + num2str(v0) + ", D_h=" + num2str(par.Dh))
xlabel('Threshold frequency $f_0$','Interpreter','Latex')
ylabel('$\kappa$','Interpreter','Latex')
legend('location','northwest','Interpreter','Latex')
ylim([0 1])
plot(f0s(:,1),kaps_measured,'.','MarkerSize',15,'DisplayName','Simulation')
plot(f0sth,kaps_theo,'--','LineWidth',2,'DisplayName','Theory')
plot(f0sth,1/4*(1+2*f0sth),'--','LineWidth',2,'DisplayName','Theory: Geometric Limit ($D_h = 0$)')
saveas(gca,'Figures\kappavsf0.pdf')