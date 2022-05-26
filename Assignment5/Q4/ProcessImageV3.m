function processedImage = ProcessImageV3(gray)
     
        S = imfilter(gray, fspecial('average', [25 25]),'replicate');
        k = 0.91;
        T = k*S;
        
        [counts,x] = imhist(gray,16);
        
        
        
end