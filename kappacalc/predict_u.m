function [u,u0,circ] = predict_u(par,kap)
    s0 = par.s0;
    alpha = par.alpha;
    v0 = par.v0;
    Df = par.Df;
    f0 = par.f0;
    
    u0 = sqrt(s0*Df/2)*(1-2*f0);
    
    alpha_upper = u0^2/2/v0/(1-kap)^2;
    alpha_lower = -u0^2/2/v0/kap^2;
    
    if alpha > alpha_upper
        circ = true;
        u = sqrt(2*alpha*v0);
    elseif alpha < alpha_lower
        circ = true;
        u = -sqrt(-2*alpha*v0);
    else 
        circ = false;
        u = ((-1+kap)*u0+kap*sqrt(2*alpha*(-1+2*kap)*v0 + u0^2))/(-1+2*kap);
    end
end

