
clc; close all; clear;
ImageDatasetPath = 'Training/images/';
GT_DateseetPath = 'Training/1st_manual/';
MaskDatasetPath = 'Training/mask/';

%ImageDatasetPath = 'Test/images/';
%GT_DateseetPath = 'Test/1st_manual/';
%MaskDatasetPath = 'Test/mask/';

TrainDataset =  LoadDataset(ImageDatasetPath);
GT_Dateseet = LoadDataset(GT_DateseetPath);
MaskDataset = LoadDataset(MaskDatasetPath);




for imageNum=1:1%size(TrainDataset,1)
    
numOfImage = imageNum;

originalWidth = size(TrainDataset{numOfImage,2},2);
originalHeight = size(TrainDataset{numOfImage,2},1);     


OriginalMask = MaskDataset{numOfImage,2};
SE = strel('disk', 3);
mask = imerode(OriginalMask,SE);

img = im2double(rgb2gray(TrainDataset{numOfImage,2}));


numOfThresh = 20;

T = im2uint8( adaptthresh(img));

level = multithresh(T,numOfThresh);
seg_I = imquantize(T,level);

final = logical(img*0);

for i=1: numOfThresh + 1
    massk = img;
    massk(seg_I~=i) = 0;
    massk(seg_I==i )= 255;

    %ringPixels = img(massk > 0);

    %newThreshold = graythresh(ringPixels);

    %BW = imcomplement(imbinarize(img,newThreshold));
    
    J = img;
    J(~massk) = 0;
    
    %S = imfilter(J, fspecial('average', 5));
    S = customFilter(J,massk,10,10);
    S(~massk) = 0;
    k = 0.97;
    T = k*S;
    processedImage = J < T;
        

    
    
    if(imageNum == 1)
        figure;imshow(J)
        figure;imshow(S)
        figure;imshow(processedImage)
    end
    final = final | processedImage;
end
final(~mask) = 0;

processedImage = bwareaopen(final, 1);
processedImage = bwmorph(processedImage,'bridge');
processedImage = bwmorph(processedImage,'bridge');
processedImage = bwmorph(processedImage,'spur');
processedImage = bwmorph(processedImage,'fill'); 
processedImage = bwmorph(processedImage,'fill'); 

SE = strel('disk', 1);
processedImage = imdilate(processedImage,SE);
SE = strel('square', 2);
processedImage = imerode(processedImage,SE);
SE = strel('square', 1);
processedImage = imerode(processedImage,SE);
SE = strel('square', 2);
processedImage = imdilate(processedImage,SE);
final = processedImage;


GT = GT_Dateseet{numOfImage,2};


[sen,spec,acc] = measure2(final, GT, mask);

Results(imageNum,1) = sen;
Results(imageNum,2) = spec;
Results(imageNum,3) = acc;


%figure;imshow(FNImage +TPImage +FPImage +TNImage )
%figure;imshow([final logical(GT) TNImage FPImage TPImage FNImage])
if(imageNum == 1)
    NotVessel = ~GT;
    NotFinal = ~final;

    TNImage = (NotVessel& NotFinal);
    TNImage(~mask) = 0;
    FPImage = (NotVessel& final);
    FPImage(~mask) = 0;
    TPImage =  (GT & final);
    TPImage(~mask) = 0;
    FNImage = logical(GT) - TPImage;
    FNImage(~mask) = 0;
    figure;imshow(rgb2gray(TrainDataset{numOfImage,2}));
    figure;imshow([ final logical(GT) TNImage FPImage TPImage FNImage])
    figure;imshow(final,[] )
   

    imwrite(final,'final_image.tif');
end

imageNum
end

[mean(Results(:,1)) mean(Results(:,2)) mean(Results(:,3))]




%%







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
