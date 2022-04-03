function [out] = EnhancePictureVer2(im)
im = double(im);
height = size(im,1);
width = size(im,2);
out = zeros( height ,  width, 1);
gamma = 0.40;
for i=1 : height
    for j=1: width
        if  im(i,j) >= 0 && im(i,j) < 60
            
            out(i,j) = GammaFunction(0.75, im(i,j)) ;
        elseif im(i,j) >= 90 && im(i,j) < 150
            out(i,j) = GammaFunction(1.3, im(i,j));
            
            
        elseif im(i,j) > 150
            out(i,j) = 255 * exp(-im(i,j) / 255);
        else
            out(i,j) = im(i,j);
        end
    end
end

out= imadjust(uint8(out));
