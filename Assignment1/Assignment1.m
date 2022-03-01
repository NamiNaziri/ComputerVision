clc; close all; clear;

[RGBImageData,width,height] = LoadImage('Test_01.ppm');

% importing the image using internal function
im = imread('Test_01.ppm');

% showing two images 

figure
subplot(1,2,1),imshow(im,[]),title('internal loader');
subplot(1,2,2),imshow(uint8(RGBImageData),[]),title('custom loader');


% end of part 1
%=====================================================================



specialImage = SpecialEffect(im);

figure
imshow(specialImage,[]);


% end of part 2
%=====================================================================

CustomRotatedImage = CustomRotate(specialImage, 266);
RotatedImage = imrotate(specialImage, 266);

figure
subplot(1,2,1),imshow(RotatedImage,[]),title('rotated by imrotate');
subplot(1,2,2),imshow(CustomRotatedImage,[]),title('rotated by custom rotation');



CustomRotatedImage = CustomRotate(specialImage, 180);
RotatedImage = imrotate(specialImage, 180);

figure
subplot(1,2,1),imshow(RotatedImage,[]),title('rotated by imrotate');
subplot(1,2,2),imshow(CustomRotatedImage,[]),title('rotated by custom rotation');


CustomRotatedImage = CustomRotate(specialImage, 30);
RotatedImage = imrotate(specialImage, 30);

figure
subplot(1,2,1),imshow(RotatedImage,[]),title('rotated by imrotate');
subplot(1,2,2),imshow(CustomRotatedImage,[]),title('rotated by custom rotation');



CustomRotatedImage = CustomRotate(specialImage, 90);
RotatedImage = imrotate(specialImage, 90);

figure
subplot(1,2,1),imshow(RotatedImage,[]),title('rotated by imrotate');
subplot(1,2,2),imshow(CustomRotatedImage,[]),title('rotated by custom rotation');
%imwrite(uint8(NewRotatedImage),'Q3.png');

% end of part 3
%=====================================================================
