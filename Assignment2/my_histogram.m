function [histogram] = my_histogram(im)
im = uint8(im);
height = size(im,1);
width = size(im,2);

histogram = zeros(1,256);
%internalHist = histogram(im);
for i=1 : height
    for j=1 : width
        histogram(im(i,j) + 1) = histogram(im(i,j) + 1) + 1;
    end
end
