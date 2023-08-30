standard_parameters
f0s = linspace(-0.45,0.25,10);
filecount = 0;
for j = 1:length(f0s)
    j
    f0 = f0s(j); par.f0 = f0; 
    u0 = (1-2*f0); 
    L = abs(u0)*T; % system size
    dx = 0.05; % space step
    if u0 > 0
        x = -L/2:dx:1.2*L; % biased grid for efficiency
    else
        x = -1.2*L:dx:L/2; % biased grid for efficiency
    end
    par.x = x;
    Le = @(x) exp(u0*x).*exp(2*x)./(1+exp(x)).^4;
    kap = integral(@(x) Le(x).*hypergeom([1 u0/Dh],1+u0/Dh,-exp(x)),-100,100)/integral(Le,-100,100);
    par.kap = kap;
    kaps(j) = kap;
    
    ac = min(u0^2/2/v0/kap^2,u0^2/2/v0/(1-kap)^2);
    alphas = linspace(-0.1*ac,0.1*ac,10);
    for k = 1:length(alphas)
        filecount = filecount + 1;
        k
        alpha = alphas(k); par.alpha = alpha;
        v = @(f) v0 + alpha*f; % growth velocity function
        pdefun = @(x,t,u,dudx) pdefuntot(x,t,u,dudx,par,v);  
        
        tic;
        sol = pdepe(0,pdefun,@(y) icfun(y),@(xl,ul,xr,ur,t) bcfun(xl,ul,xr,ur,t),x,t);
        toc;
        f0ind = j;
        alphaind = k;
        save("datanew\data" + num2str(filecount) + ".mat",'sol','par','kap','f0ind','alphaind')
    end
end