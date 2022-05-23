clc; close all; clear;
img = im2double(imread('Q2/Cells.tif'));
S = imfilter(img, fspecial('average', [3 21]),'replicate');


thresh = multithresh(img,1);
BW = imquantize(img,thresh);

T = adaptthresh(img, 0);
BW_Adapt = imbinarize(img,T);

SE = strel('square',3);

final_image= imopen(BW_Adapt + BW,SE);
ff = final_image > 1;
final_image (ff ) = 1;
final_image (~ff ) = 0;


height = size(final_image,1);
width = size(final_image,2);

% use the help of a bigger matrix
B=nan(size(final_image)+2);
B(2:end-1,2:end-1)=final_image;

% pre-define memory for result
tmpResult = 0*B;
result = 0 *final_image;
cellCount = 1;

% calculate!
for i=2:size(final_image,1)+1
  for j=2:size(final_image,2)+1
      
    if(B(i,j) == 1)
        if(tmpResult(i,j) == 0) % agar meghdar nadarad
            tmpResult(i,j) = cellCount;
            
            %function
            tmpResult = findNeighbours(B, tmpResult,i,j, cellCount);
            cellCount = cellCount + 1;
        end

    end
  end
end


figure;imshow(result,[]);
