function processedImage = ProcessImageV2(gray) %81.2071   91.2524   89.9424 
     
     
         S = imfilter(gray, fspecial('disk', 10),'replicate');
        k = 0.97;
        T = k*S;
        processedImage = gray < T;


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