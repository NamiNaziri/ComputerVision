function [] = Q3()


ImageDatasetPath = 'Questions/Q3/';

%FeatureDataset = cell(1000,4);

s = dir(ImageDatasetPath);

k = 1;
for i=1:numel(s)
    if s(i).isdir == 0
        I = imread([ImageDatasetPath s(i).name]);
        FeatureDataset{k,1} = s(i).name;
        Answer = s(i).name(find(s(i).name == '_', 1, 'last') + 1: end - 4);
         FeatureDataset{k,2} = str2num(Answer);
        
        f = RGBMid(I,3);
        f = RGBMid(f,3);
        %f = RGBMid(f,3);
        %f = RGBMid(f,3);
        
        FeatureDataset{k,4} = RGBMid(f,3);
        
        M = repmat(all(I<10,3),[1 1 3]);
        I(M) = 255;
        
        
        
        H = fspecial('Average', [3,3]);
        I = imfilter(I,H);
        FeatureDataset{k,3} = imfilter(rgb2gray(I),H); 
        %FeatureDataset{k,3} = medfilt2(rgb2gray(I),[2,2]);
        
        
        
        


        k = k + 1;
    end
end
%%

ImageSourcePath = 'Questions/Q3_Source/';
SourceDataset = cell(9,3);

s = dir(ImageSourcePath);

L = 1;
for i=1:numel(s)
    if s(i).isdir == 0
        I = imread([ImageSourcePath s(i).name]);
        SourceDataset{L,1} = s(i).name;
        
        Answer = s(i).name(find(s(i).name == '_', 1, 'last') + 1: end - 4);
        SourceDataset{L,2} = I;
        SourceDataset{L,3} = str2num(Answer);

        L = L + 1;
    end
end

%%
class = 14;
rightGuesses = 0;

sourceWidth = 60;
sourceHeight = 100;

threshold1 = 100;


for p=1 : size(FeatureDataset,1)
testImage = imcomplement(im2double(FeatureDataset{p,3})) ;
testImage = testImage(8:end - 60,8: end - 10);
VerticalScan = sum( testImage()) ;

[xMin,xMax] = findMinMaxArray(VerticalScan);
HorizontalScan = (sum( testImage,2 ))' ;

[yMin,yMax] = findMinMaxArray(HorizontalScan);



finalAnswer = 0;


    for i = 1 : min(size(xMin,2),size(xMax,2))
        for j = 1 : min(size(yMin,2),size(yMax,2))
            cropedImage = testImage(yMin(j):yMax(j),xMin(i):xMax(i));
            if sum(cropedImage(:)) > 5
                VerticalScan = sum( cropedImage()) ;

                [xMin1,xMax1] = findMinMaxArray(VerticalScan);
                HorizontalScan = (sum( cropedImage,2 ))' ;

                [yMin1,yMax1] = findMinMaxArray(HorizontalScan);

                cropedImageHeight = size(cropedImage,1);
                cropedImageWidth = size(cropedImage,2);

                f = FeatureDataset{p,4}(yMin(j) +6  + yMin1: yMax(j) + 6  - (cropedImageHeight - yMax1) ,xMin(i) +6 + xMin1: xMax(i) + 6 -(cropedImageWidth - xMax1),:);
                %f = FeatureDataset{35,4}(yMin(j) +6:yMax(j) + 6,xMin(i) + 6:xMax(i) + 6,:);
                f = imresize(f,[sourceHeight,sourceWidth]);

                red = f(:,:,1);
                blue = f(:,:,3);
                
                isPositive = sum(red(:)) > sum(blue(:));

                sign = -1;
                if isPositive 
                    sign = 1; 
                end


                minError = 10000000;
                selectedImage = 1;

                if( abs (sum(red(:)) - sum(blue(:))) > threshold1)

                    for l = 1 : size(SourceDataset,1)
                        err = immse(double(imbinarize(rgb2gray(f),'global')),double(imbinarize(rgb2gray(SourceDataset{l,2}),'global')));
                        if(err < minError)
                           selectedImage = l;
                            minError = err;
                        end
                    end
                    if( p == class)
                        figure; imshow([im2bw(f) im2bw(SourceDataset{selectedImage,2})]);
                        %figure; imshow(f );
                        imwrite (f,[num2str(i) num2str(j) '.png']);
                    end
                    a = sign * SourceDataset{selectedImage,3};
                    finalAnswer = finalAnswer + a;
                   
                end
            end
        end
    end
if FeatureDataset{p,2} == finalAnswer
    rightGuesses = rightGuesses + 1;
else
    p
end
end
%%
I = imread([ImageDatasetPath FeatureDataset{14,1}]);
figure;imshow(I)

I = RGBMid(I,3);
I = RGBMid(I,3);
%H = fspecial('gaussian', [2,2],2/6);


I=imbinarize(rgb2gray(I),'global');

I = medfilt2(I, [3 3]);
figure;imshow(I)
%im = imread('Untitled.png');


end