function [out]= ExtractNumber(img)
    
testImage = imcomplement(im2double(img)) ;
VerticalScan = sum( testImage()) ;

[xMin,xMax] = findMinMaxArray(VerticalScan);
HorizontalScan = (sum( testImage,2 ))' ;

[yMin,yMax] = findMinMaxArray(HorizontalScan);

out = img(yMin(1):yMax(1),xMin(1):xMax(1),:);

end