function [out] = EnhancePictureVer3(im)
im = im2double(im);
gamma = 0.31;
alpha = power(double(255),(1-gamma));
out = alpha* power(double(im),gamma);
out= imadjust(uint8(out),[0.01,0.2],[0.13,1]);