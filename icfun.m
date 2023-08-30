function u0 = icfun(x)
u0 = [heaviside(x+2)-heaviside(x-2); 0];
end
