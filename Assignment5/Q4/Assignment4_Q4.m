
clc; close all; clear;
img = imread('Training/images/31_training.tif');
%imshow(img);

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

cr = img(250:350,250:350,:);
imshow(rgb2gray(cr))

adapt = im2uint8(adaptthresh(rgb2gray(cr),0.2,'ForegroundPolarity','dark'));

thresh = multithresh(rgb2gray(cr) - adapt ,1);
seg_I = imquantize(rgb2gray(cr) - adapt,thresh);

imshow(adapt,[])


%%

IM3Gray = rgb2gray(cr);
mask = imbinarize(IM3Gray,'global');

T = adaptthresh(IM3Gray);

windowSize = 2;
kernel = ones(windowSize);
kernel = kernel / sum(kernel(:));
localAverageImage = conv2(double(IM3Gray), kernel, 'same');

h = fspecial('disk',44);
filteredRGB = imfilter(IM3Gray, h);
filteredRGB(~mask) = 0;


adapt = im2uint8(adaptthresh(IM3Gray,0.8,'ForegroundPolarity','dark'));
adapt(~mask) = 0;

newimg = imbinarize(IM3Gray,adapt);


thresh = multithresh(adapt - IM3Gray ,4);
seg_I = imquantize(adapt - IM3Gray ,thresh);

RGB = label2rgb(seg_I); 	 
figure;
imshow( seg_I,[])
%ringPixels = newimg(mask >0); % No black pixels here
%newThreshold = graythresh(ringPixels);
%BW = imbinarize(newimg,newThreshold);
%BW(~mask) = 0;

se = strel('disk',1);

figure;imshow([filteredRGB filteredRGB + IM3Gray adapt - IM3Gray IM3Gray ])
