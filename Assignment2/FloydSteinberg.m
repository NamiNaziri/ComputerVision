function [floydSteinbergImage] = FloydSteinberg(im)
height = size(im,1);
width = size(im,2);

greyImage = double(rgb2gray(im));
%figure
%imshow(greyImage,[]);
floydSteinbergImage = zeros(height, width);


for i=1 : height
    for j=1 : width

        if( greyImage(i,j) >= 127.5 ) %white
            floydSteinbergImage(i,j) = 255;
        else                       %black
            floydSteinbergImage(i,j) = 0;    
        end
        
        error = greyImage(i,j) - floydSteinbergImage(i,j); 
        if(j+1 <= width)
            greyImage(i,j + 1) = greyImage(i,j + 1) + error * ( 7 / 16);
        end

        if( i+1 <= height)
            if(j+1 <= width)
                greyImage(i+1,j+1) = greyImage(i+1,j+1) + error * (1/16); 
            end
            if(j-1 >= 1)
                greyImage(i+1,j-1) = greyImage(i+1,j-1) + error * (3/16); 
            end
            greyImage(i + 1,j) = greyImage(i + 1,j) + error * (5/16); 
        end
    end
end

internalWith3Dim = zeros(height, width, 3);

internalWith3Dim(:,:,1) = floydSteinbergImage(:,:);
internalWith3Dim(:,:,2) = floydSteinbergImage(:,:);
internalWith3Dim(:,:,3) = floydSteinbergImage(:,:);


%im = double(imread('Q5/House.png'));

%psnr(internalWith3Dim,im)
