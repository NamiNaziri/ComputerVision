function output = SpecialEffect(im,width,height)

width = size(im,1);
height = size(im,2);

% create gray image
GrayImage = rgb2gray(im)

% properties of the oval
OvalHalfWidth = 200;
OvalHalfHeight = 400;

OvalHalfWidthPow2 = OvalHalfWidth * OvalHalfWidth;
OvalHalfHeightPow2 = OvalHalfHeight * OvalHalfHeight ;

%Properties of the dimond
DimondHalfWidth = 100;
DimondHalfHeight = 200;

for i=1 : width
    for j=1 :  height
        % Check if the pixels is insinde the Oval and outside of the dimond
        if  (round(((((i - (width/2))^2) / OvalHalfHeightPow2) +  (((j - (height/2))^2) / OvalHalfWidthPow2)),2) <= 1 ) & (round( abs( (i - (width/2) ) / DimondHalfHeight) + abs( (j - (height/2)) / DimondHalfWidth), 2) >= 1)
            im(i,j,1) = 255;
            im(i,j,2) = 0;
            im(i,j,3) = 0;
        end
        % If its outside of the oval turn the pixel into gray
        if  (round(((((i - (width/2))^2) / OvalHalfHeightPow2) +  (((j - (height/2))^2) / OvalHalfWidthPow2)),2) > 1 )
            im(i,j,1) = GrayImage(i,j);
            im(i,j,2) = GrayImage(i,j);
            im(i,j,3) = GrayImage(i,j);
        end
    end
end

% write the image into jpg file
imwrite(im,'Q2.jpg','Quality',100);
output = uint8(im);

end