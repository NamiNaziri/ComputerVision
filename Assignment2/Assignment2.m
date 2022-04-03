clc; close all; clear;

%im = imread('Untitled.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Question 3.a
im = imread('Untitled.png');
BestBWPsnr(im);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Question 3.b

im = imread('Q5/House.png');
greyImage = double(rgb2gray(im));
out = FloydSteinberg(im);
figure
imshow([greyImage uint8(out)])




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Question 4
%{
img = imread('Q5/LR_House.png');
resizedImage = CustomResize(img,2);
figure 
imshow(resizedImage);
resizedImage = CustomResize(img,0.3);
figure 
imshow(resizedImage);
resizedImage = CustomResize(img,0.76);
figure 
imshow(resizedImage);
resizedImage = CustomResize(img,6);
figure 
imshow(resizedImage);
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Question 5

src = imread('Q5/House.png');
Inimg = imread('Q5/LR_House.png');
srcheight = size(src,1);
srcwidth = size(src,2);
%imshow(tempDes)

%psnr(tempDes,im)
% The second parameter is the magic number. by changing it we can produce
% better quality images. ofcourse based on the current sample test cases
% the magic number of 1 gives us the best quality. but 0.2 gives us almost
% best quality in every cases.

tic
final = DHInterpolation(Inimg,0.2);
toc

resized = imresize(Inimg,2,'Bilinear');
%imshow(uint8(final));

psnr(uint8(resized), src)
psnr(uint8(final), src)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Question 6

% Reading the image
im = imread('Q6/Image.tif');


% creating and showing the histogram
histogram = my_histogram(im);
histogram(1) = 0;
figure
bar([0:255],histogram);


%out = EnhancePicture(im);
%out =EnhancePictureVer2(im);
out =EnhancePictureVer3(im);


newhis = my_histogram(out);
newhis(1) = 0;
figure
bar([0:255],newhis);

figure
imshow([im uint8(out)])

