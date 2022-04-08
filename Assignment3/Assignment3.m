clc; close all; clear;

ImageDatasetPath = 'Questions/Q3/';
FeatureDataset = cell(1000,4);

s = dir(ImageDatasetPath);

k = 1;
for i=1:numel(s)
    if s(i).isdir == 0
        I = imread([ImageDatasetPath s(i).name]);
        FeatureDataset{k,1} = s(i).name;
        Answer = s(i).name(find(s(i).name == '_', 1, 'last') + 1: end - 4);
        FeatureDataset{k,2} = str2num(Answer);
        FeatureDataset{k,3} = medfilt2(rgb2gray(I),[6,6]);
        
        
        
        FeatureDataset{k,4} = RGBMid(I);


        k = k + 1;
    end
end

%%
testImage = imcomplement(im2double(FeatureDataset{k-2,3})) ;
testImage = testImage(2:end - 60,3: end - 3);
VerticalScan = sum( testImage()) ;

[xMin,xMax] = findMinMaxArray(VerticalScan);
HorizontalScan = (sum( testImage,2 ))' ;

[yMin,yMax] = findMinMaxArray(HorizontalScan);


for i = 1 : size(xMin,2)
    for j = 1 : size(yMin,2)
        cropedImage = testImage(yMin(j):yMax(j),xMin(i):xMax(i));
        if sum(cropedImage(:)) > 5
            figure 
            imshow(FeatureDataset{k-2,4}(yMin(j):yMax(j),xMin(i):xMax(i),:),[])
        end
    end
end
%im = imread('Untitled.png');