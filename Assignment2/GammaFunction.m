function [out] = GammaFunction(gamma,x)
alpha = power(double(255),(1-gamma));
out = alpha* power(x,gamma);