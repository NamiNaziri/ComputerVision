
clc; close all; clear;
img = im2double(imread('Training/images/31_training.tif'));
mask = imread('Training/mask/31_training_mask.gif');
gray = rgb2gray(img);
 

S = imfilter(img, fspecial('average', [3 21]),'replicate');

k = 0.97;
T = k*S;
f = img < T;

hist = imhist(gray(mask>0));

figure;imhist(gray(mask>0));
T = otsuthresh(hist);
BW = imbinarize(gray,T);
ff = gray>T;
A = gray;
A(ff) = 0;
B = gray;
B(~ff) = 0;

Bhist = imhist(B(B > 0));
%BT = otsuthresh(Bhist);
BT = multithresh(B,7);
BBW = imbinarize(B,BT);

figure;imshow( BBW );
%%

padding = 50;

cr = gray(200:250,350:400);



S = imfilter(cr, fspecial('average', [6 6]),'replicate');
k = 0.93;
T = k*S;

final = cr > T;
SE = strel('square',3);
finalIMOPEN = imopen(final,SE);

imshow([cr T final finalIMOPEN]);
figure; imshow([cr - T ],[]);

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
