clc; close all; clear;

%im = imread('Untitled.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Question 3.b

%im = imread('Untitled.png');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Question 4

src = imread('Q5/House.png');
im = imread('Q5/LR_House.png');

height = size(im,1);
width = size(im,2);

resizedImage = uint8(zeros( ceil(height * 2) ,  ceil(width * 2), size(im,3)));

resizedHeight = size(resizedImage,1);
resizedWidth = size(resizedImage,2);

old_i = 1;
old_j = 1;

for i=1 : resizedHeight
    for j=1 : resizedWidth
        if mod((j-1), 2) == 0
            if mod((i-1), 2) == 0
                resizedImage(i,j,:) = im((i+1)/2,(j+1)/2,:);
                old_j = old_j + 1;
            else
                resizedImage(i,j,:) = zeros(1,1,size(im,3));
            end
            
            
        end
    end
end


for i=1 : resizedHeight
    for j=1 : resizedWidth
        
        if mod(i, 2) == 0
            if mod(j,2) == 0

                top = min(max(floor(i-1),1),resizedHeight);
                bottom = min(max(ceil(i+1),1),resizedHeight);
                left = min(max(floor(j-1),1),resizedWidth);
                right = min(max(ceil(j+1),1),resizedWidth);

                topLeftPixle = double(resizedImage(top,left,:));
                topRightPixle = double(resizedImage(top,right,:));
                bottomRightPixle = double(resizedImage(bottom,right,:));
                bottomLeftPixle = double(resizedImage(bottom,left,:));

                resizedImage(i,j,:) = (topLeftPixle + topRightPixle + bottomRightPixle + bottomLeftPixle) /4;
            end
        end

    end
end

for i=1 : resizedHeight
    for j=1 : resizedWidth
        
        if mod(i, 2) ~= 0 % i is odd
            if mod(j,2) == 0 % j is even

                top = min(max(floor(i-1),1),resizedHeight);
                bottom = min(max(ceil(i+1),1),resizedHeight);
                left = min(max(floor(j-1),1),resizedWidth);
                right = min(max(ceil(j+1),1),resizedWidth);

                topPixle = double(resizedImage(top,j,:));
                RightPixle = double(resizedImage(i,right,:));
                bottomPixle = double(resizedImage(bottom,j,:));
                LeftPixle = double(resizedImage(i,left,:));
                if i == 1 
                    resizedImage(i,j,:) = (RightPixle + bottomPixle + LeftPixle) / 3;
                elseif i == resizedHeight || i == resizedHeight -1
                        resizedImage(i,j,:) = (RightPixle + topPixle + LeftPixle) / 3;
                else
                    resizedImage(i,j,:) = (topPixle + RightPixle + bottomPixle + LeftPixle) /4;
                end
                
            end
        end
        
        if mod(i, 2) == 0 % i is even
            if mod(j,2) ~= 0 % j is odd

                top = min(max(floor(i-1),1),resizedHeight);
                bottom = min(max(ceil(i+1),1),resizedHeight);
                left = min(max(floor(j-1),1),resizedWidth);
                right = min(max(ceil(j+1),1),resizedWidth);

                topPixle = double(resizedImage(top,j,:));
                RightPixle = double(resizedImage(i,right,:));
                bottomPixle = double(resizedImage(bottom,j,:));
                LeftPixle = double(resizedImage(i,left,:));
                if j == 1 
                    resizedImage(i,j,:) = (topPixle + RightPixle + bottomPixle) / 3;
                elseif j == resizedWidth || j == resizedWidth - 1
                    resizedImage(i,j,:) = (topPixle + LeftPixle + bottomPixle) / 3;
                else
                    resizedImage(i,j,:) = (topPixle + RightPixle + bottomPixle + LeftPixle) /4;
                end
                
            end
        end

    end
end

resizedImage(resizedHeight,:,:) = resizedImage(resizedHeight-1,:,:);
resizedImage(:,resizedWidth,:) = resizedImage(:,resizedWidth-1,:);

resized = imresize(im,2,'bilinear');
imshow(resizedImage);

psnr(resizedImage, src)
