clc; close all; clear;

[RGBImageData,width,height] = LoadImage('Test_01.ppm');

% importing the image using internal function
im = imread('Test_01.ppm');

% showing two images 

%subplot(1,2,1),imshow(im,[]),title('1');
%subplot(1,2,2),imshow(uint8(RGBImageData),[]),title('2');


% end of part 1
%=====================================================================



specialImage = SpecialEffect(im);

imshow(specialImage,[]);
%imwrite(im,'Q2.jpg','Quality',100);

% end of part 2
%=====================================================================

angle = 90;

CustomRotatedImage = CustomRotate(specialImage, 90);

RotatedImage = imrotate(im, 266);

%subplot(1,2,1),imshow(RotatedImage,[]),title('rotated by imrotate');
%subplot(1,2,2),imshow(CustomRotatedImage,[]),title('2');
ff=CustomRotatedImage(:,:,2);
imshow(CustomRotatedImage,[]);
%imwrite(uint8(NewRotatedImage),'Q3.png');


