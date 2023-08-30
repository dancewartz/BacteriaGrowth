clear; close all; clc;
v0 = 10; par.v0 = v0; % upward velocity, can be whatever
alpha = -0.3; par.alpha = alpha; 
s0 = 2; par.s0 = s0;% selection coefficient

Df = 1; par.Df = Df; % f diffusion
Dh = 1; par.Dh = Dh; % h diffusion

T = 200; % total time
dt = 1; % NOT TIME STEP, JUST WHEN SOLUTION IS GIVEN
t = dt:dt:T; par.t = t;% time vector

