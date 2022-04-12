function [] = Q4()
clc; close all; clear;

ImageDatasetPath = 'Questions/Q4/';

s = dir(ImageDatasetPath);

d = 0.1;

k = 1;

filterKernelSizeWidth = 5;
filterKernelSizeHeight = 5;

for i=1:numel(s)
    if s(i).isdir == 0
        I = imread([ImageDatasetPath s(i).name]);
        
        
        medSUM = 0;
        customSUM = 0;
        for j = 1 : 9 %10 percent to 90 percent noise
            J = imnoise(I,'salt & pepper', d * j);
            finalPic = customFilter(J,filterKernelSizeHeight,filterKernelSizeWidth);
        
        
            med = medfilt2(J, [filterKernelSizeHeight filterKernelSizeWidth]);
            medPSNR = psnr(I, med);
            medSUM = medSUM + medPSNR;
            
            customFilterPSNR = psnr(I, finalPic);
            customSUM = customSUM + customFilterPSNR;
            
            % Remove these comments to see the images
            %figure
            %imshow([J med finalPic]);
            %title ( ['Noise: ' num2str(d * j * 100) '%  '  'median psnr: ' num2str(medPSNR,'%f') '  custom filter psnr: ' num2str(customFilterPSNR,'%f')]);

        end
        [s(i).name ' Median: ' num2str(medSUM/9) ' custom: ' num2str(customSUM/9)]
        k = k + 1;
    end
end
end