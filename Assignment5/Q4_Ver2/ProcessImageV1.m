function processedImage = ProcessImageV1(gray) %78.3481   93.1664   91.2504
     
        S = imfilter(gray, fspecial('disk', 10),'replicate');
        k = 0.97;
        T = k*S;
        processedImage = gray < T;

        
        processedImage = bwmorph(processedImage,'spur');
        processedImage = bwmorph(processedImage,'fill');

        processedImage = bwareaopen(processedImage, 3);
        processedImage = bwmorph(processedImage,'bridge');
        processedImage = bwmorph(processedImage,'bridge');
        processedImage = bwmorph(processedImage,'spur');
        processedImage = bwmorph(processedImage,'fill');
        
        SE = strel('disk', 1);
        processedImage = imdilate(processedImage,SE);
        SE = strel('square', 2);
        processedImage = imerode(processedImage,SE);
        SE = strel('square', 1);
        processedImage = imerode(processedImage,SE);
        SE = strel('square', 2);
        processedImage = imdilate(processedImage,SE);

end