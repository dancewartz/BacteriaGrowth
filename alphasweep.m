standard_parameters;
alphas = linspace(-1*0.4,2*0.4,30); 

for k = 1:length(alphas)
    k
    alpha = alphas(k); par.alpha = alphas(k);
    v = @(f) v0 + alpha*f;
    [u,u0,circ] = predict_u(par);
    L = abs(u)*T; % system size
    dx = 0.05; % space stepq
    
    x = -L/5:dx:1.2*L; % biased grid for efficiency
    
    par.x = x;
    
    pdefun = @(x,t,u,dudx) pdefuntot(x,t,u,dudx,par,v);  
    tic;
    sol = pdepe(0,pdefun,@(y) icfun(y),@(xl,ul,xr,ur,t) bcfun(xl,ul,xr,ur,t),x,t);
    toc;

    get_u

    us(k) = u_measured;
    
    filename = "data" + num2str(k);
    save("alphasweepdata3\"+filename+".mat",'sol','u_measured','par')
end
