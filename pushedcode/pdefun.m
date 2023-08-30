function [c, f, s] = pdefun(x, t, u, Du, par)
    % Define the system of PDE
    c = [1; 1];
    f = [par.Df * Du(1); par.Dh * Du(2)];
    s = [par.s0 * (u(1)-par.f0) * u(1) * (1 - u(1)) + par.v0 * Du(1) * Du(2);
        1 + par.alpha * u(1) + par.v0 / 2 * (Du(2))^2];
end
