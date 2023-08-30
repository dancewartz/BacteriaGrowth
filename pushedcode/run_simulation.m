function run_simulation(ind)
    close all
    % define parameters
    par.Df = 1; 
    par.Dh = 1; 
    par.v0 = 20;
    par.s0 = 4;
    par.u0 = sqrt(par.s0*par.Df/2)*2;
    T = 300; % was 300
    dt = 1;
    t = dt:dt:T; par.t = t;

    L = 5*par.u0*T; % was 5 u0 T
    dx = 0.1; 
    x = 0:dx:L; par.x = x;
    par.x0 = L/2;

    alpha_values = linspace(-0.2,0.2,45);
    f0_values = linspace(-0.3,0.3,11); 

    % Create a grid of alpha and f0 values and select specific combination
    [alpha_grid, f0_grid] = meshgrid(alpha_values, f0_values);

    par.alpha = alpha_grid(ind);
    par.f0 = f0_grid(ind);

    m = 0; % represents the problem symmetry. Should be 0 for your case

    sol = pdepe(m, @(x, t, u, Du)pdefun(x, t, u, Du, par), ...
                   @(x)icfun(x, par), ...
                   @bcfun, x, t);
                   
    %save(['datacubic/solution_' num2str(ind) '.mat'],'sol','par')
    
    for j = 1:length(t)
        loc = find(sol(j,:,1)>0.9,1,'last');
        ws(j) = x(loc);
    end
    p = polyfit(t(t>0.8*t(end)),ws(t>0.8*t(end)),1);
    u = p(1)
    
    p = polyfit(par.t(par.t>0.8*par.t(end)),ws(par.t>0.8*par.t(end)),1);
    u = p(1);

    % Save the solutions
    %save(['datacubic/solution_' num2str(ind) '.mat'], 'par','u');
end
