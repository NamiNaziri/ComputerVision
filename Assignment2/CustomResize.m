function [resizedImage] = CustomResize(im,resizingFactor)

originalHeight = size(im,1);
originalWidth = size(im,2);


resizedImage = zeros( ceil(originalHeight * resizingFactor) ,  ceil(originalWidth * resizingFactor), 3);

resizedHeight = size(resizedImage,1);
resizedWidth = size(resizedImage,2);

for i=1 : resizedHeight
    for j = 1: resizedWidth
        currentHeightPos = (double(i) / resizingFactor) ;
        currentWidthPos = (double(j) / resizingFactor);

        
        top = min(max(floor(currentHeightPos),1),originalHeight);
        bottom = min(max(ceil(currentHeightPos),1),originalHeight);
        left = min(max(floor(currentWidthPos),1),originalWidth);
        right = min(max(ceil(currentWidthPos),1),originalWidth);
        
        HeightAlpha = currentHeightPos - top;
        WidthtAlpha = currentWidthPos - left;
        
        topLeftPixle = double(im(top,left,:));
        topRightPixle = double(im(top,right,:));
        bottomRightPixle = double(im(bottom,right,:));
        bottomLeftPixle = double(im(bottom,left,:));
        
        resizedImage(i,j,:) = topLeftPixle + ...
        (topRightPixle - topLeftPixle) * WidthtAlpha + ...
        (bottomLeftPixle - topLeftPixle) * HeightAlpha + ...
        (topLeftPixle - topRightPixle - bottomLeftPixle + bottomRightPixle) * WidthtAlpha * HeightAlpha;
        
    end
end
resizedImage = uint8(resizedImage);
%figure
%imshow(uint8(resizedImage),[]);

%internalResize =imresize(im,0.2,"bilinear","Antialiasing",false);

%figure
%imshow(uint8(internalResize),[]);
%psnr(uint8(resizedImage),uint8(internalResize))