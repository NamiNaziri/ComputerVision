function processedImage = ProcessImageV2(gray)
     
        S = imfilter(gray, fspecial('average', [25 25]),'replicate');
        k = 0.91;
        T = k*S;
        processedImage = gray < T;
        SE = strel('disk', 1);
        processedImage = imdilate(processedImage,SE);
        SE = strel('square', 3);
        %processedImage = imerode(processedImage,SE);
        SE = strel('square', 1);
        %processedImage = imerode(processedImage,SE);
        SE = strel('square', 1);
        %processedImage = imdilate(processedImage,SE);
        
end