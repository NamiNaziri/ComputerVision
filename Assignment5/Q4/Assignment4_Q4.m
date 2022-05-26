
clc; close all; clear;
ImageDatasetPath = 'Training/images/';
GT_DateseetPath = 'Training/1st_manual/';
MaskDatasetPath = 'Training/mask/';

TrainDataset =  LoadDataset(ImageDatasetPath);
GT_Dateseet = LoadDataset(GT_DateseetPath);
MaskDataset = LoadDataset(MaskDatasetPath);

%6
numOfImage = 3;

originalWidth = size(TrainDataset{numOfImage,2},2);
originalHeight = size(TrainDataset{numOfImage,2},1);


patchSizeX = 25;
patchSizeY = 20;


imageCell = CreatePatches(TrainDataset{numOfImage,2},patchSizeX,patchSizeY);
GT = GT_Dateseet{numOfImage,2};
OriginalMask = MaskDataset{numOfImage,2};
SE = strel('disk', 3);
mask = imerode(OriginalMask,SE);

for i=1:size(imageCell,1)
    for j=1:size(imageCell,2)
        img = imageCell{i,j};
        gray = rgb2gray(img);


        S = imfilter(gray, fspecial('average', [15 15]),'replicate');
        k = 0.97;
        T = k*S;
        f = gray < T;

        SE = strel('disk', 1);
        f = imdilate(f,SE);
        SE = strel('square', 3);
        f = imerode(f,SE);
        SE = strel('square', 1);
        f = imerode(f,SE);
        SE = strel('square', 3);
        f = imdilate(f,SE);
        imageCell{i,j} = f;
    end
end

final = CellToImage(imageCell);

finalWidth = size(final,2);
finalHeight = size(final,1);


NewCol = zeros(finalHeight,uint8(originalWidth - finalWidth));
NewRow = zeros(uint8(originalHeight - finalHeight),originalWidth);

final = [final NewCol];
final = [final; NewRow];
final(~mask) = 0;

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


FN = sum(FNImage(mask > 1));
TP = sum(TPImage(mask > 1));
FP = sum(FPImage(mask > 1));
TN = sum(TNImage(mask > 1));

sen = TP / (TP+FN) * 100
spec = TN / (TN+FP) * 100
acc = (TP + TN) / (TP+TN+FP+FN) *100


%figure;imshow(FNImage +TPImage +FPImage +TNImage )
figure;imshow([final logical(GT) TNImage FPImage TPImage FNImage])

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
