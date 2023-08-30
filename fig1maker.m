clear; close all; clc; 

figure
hold on
set(gca,'fontsize',15)
xlabel('Expansion Speed Difference $\alpha$','Interpreter','Latex')
ylabel('Invasion Velocity $u$','Interpreter','Latex')
title('$s(f) = s_0$','Interpreter','Latex')

colors = ["b","r","k"];
mkrs = ['s','o','+'];

count = 0;
for directory_ind = 1:3
    dir_name = "alphasweepdata" + num2str(directory_ind);
    for file_ind = 1:30
        file_name = "data" + num2str(file_ind) + ".mat";
        load(dir_name + "\" + file_name,'u_measured','par')
        us(directory_ind,file_ind) = u_measured;
        alphas(file_ind) = par.alpha;
        s0s(directory_ind,file_ind) = par.s0;
        count = count+1
    end
    plot(alphas,us(directory_ind,:),colors(directory_ind)+mkrs(directory_ind),'MarkerSize',7,'LineWidth',1.5,'DisplayName',"$s_0 = $" + num2str(par.s0))
    l = legend('Location','SouthEast','FontSize',20);
    set(l,'Interpreter','latex')
    plot(alphas,2*sqrt(par.s0*par.Df)*ones(size(alphas)),colors(directory_ind)+"--",'LineWidth',2,'Handlevisibility','off')
end
plot(alphas,sqrt(2*alphas*par.v0),'--','LineWidth',2,'HandleVisibility','off')
ylim([1 4])
