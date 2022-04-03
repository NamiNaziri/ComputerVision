function [out] = EnhancePicture(im)
im = im2double(im);
gamma = 0.015;
alpha = power(double(255),(1-gamma));
out = alpha* power(double(im),gamma);
out= imadjust(uint8(out),[0.8,0.95],[0,0.98]);
%out= imadjust(uint8(out));
