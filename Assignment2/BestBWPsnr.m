function [BWImage] = BestBWPsnr(im)

% importing the image
im = im2double(im);

width = size(im,1);
height = size(im,2);



BWImage = zeros(width, height, 3);
%figure
%imshow(im);

%converting the image using AVG of 3 channels.This will give us the best
%psnr
for i = 1 : width
    for j=1 : height
        avg = (im(i,j,1) + im(i,j,2) + im(i,j,3)) /3;
        num = 0;
        if( avg >= 0.5 ) %white
            num = 1;
        end
        BWImage(i,j,1) = num;
        BWImage(i,j,2) = num;
        BWImage(i,j,3) = num;
        
    end
end


%figure
%imshow(internalWith3Dim,[]);
psnr(BWImage,im)
%psnr(internalWith3Dim,im)
