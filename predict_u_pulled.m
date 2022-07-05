function [u,u0,circ] = predict_u_pulled(s0,alpha,lambda)
    u0 = 2*sqrt(s0);
    if 2*alpha*lambda > u0^2
        u = sqrt(2*alpha*lambda);
        circ = true;
    else
        u = u0;
        circ = false;
    end
end

