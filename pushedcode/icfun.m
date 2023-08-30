function u0 = icfun(x, par)
    % Define initial conditions
    u0 = [heaviside(-(x-par.x0)); 0];
end
