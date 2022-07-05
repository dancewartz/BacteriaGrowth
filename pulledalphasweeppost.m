clear; close all; clc; 
folder = "pulledalphasweepdatafromcluster\";

if ~isfolder(folder)
    errorMessage('ERROR, NO FOLDER FOUND')
end

filePattern = fullfile(folder,'*.mat');
theFiles = dir(filePattern);

us = NaN*ones(size(theFiles));

for j = 1:length(theFiles)
    filename = theFiles(j).name;
    load(folder + filename);
    
    dt = par.dt; T = par.T; dx = par.dx; L = par.L;
    
    x = -L:dx:L;
    t = dt:dt:T;
    
    % Find velocity
    tind = []; xind = [];
    for j = 1:length(t)
        fsol = sol(j,:,1);
        hsol = sol(j,:,2);
        active = fsol > 0.5;


        ind = find(fsol > 0.5,1,'last');
        tind(end+1) = t(j);
        xind(end+1) = x(ind);
    end
    p = polyfit(tind(tind>T/1.7),xind(tind>T/1.7),1);
    us(par.k) = p(1);
    alphas(par.k) = par.alpha;
end

figure
hold on
xlabel('Expansion Speed Difference','Interpreter','Latex')
ylabel('Invasion Velocity $u$','Interpreter','Latex')
ylim([0,max(us)+1])
set(gca,'LineWidth',3,'FontSize',15)
plot(alphas,us,'.','MarkerSize',15)
plot(alphas,max(us(1),sign(alphas).*sqrt(2*abs(alphas)*par.lambda + alphas.^2)),'--','LineWidth',3)