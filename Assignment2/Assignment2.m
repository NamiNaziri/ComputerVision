clc; close all; clear;

% importing the image
im = im2double(imread('Untitled.png'));

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

figure
imshow(BWImage,[]);

% convert image to gray using the internal function
% this function using the following weights 0.2989 * R + 0.5870 * G + 0.1140 * B 

%figure
%imshow(internalWith3Dim,[]);
psnr(BWImage,im)
%psnr(internalWith3Dim,im)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Question 3.b

im = imread('Untitled.png');
height = size(im,1);
width = size(im,2);

greyImage = double(rgb2gray(im));
figure
imshow(greyImage,[]);
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

figure
imshow(uint8(floydSteinbergImage),[]);
imshow(uint8(floydSteinbergImage),[]);
im = double(imread('Untitled.png'));

psnr(internalWith3Dim,im)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Question 4

im = imread('Untitled.png');
originalHeight = size(im,1);
originalWidth = size(im,2);

resizingFactor = 2.0;

resizedImage = zeros(originalHeight * resizingFactor , originalWidth * originalWidth, 3);

resizedHeight = size(resizedImage,1);
resizedWidth = size(resizedImage,2);

for i=1 : resizedHeight
    for j = 1: resizedWidth
        currentPos = ((i - 1) / resizingFactor) + 1;
    end
end

