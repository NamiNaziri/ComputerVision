function []= ExtractNumbers(img)

testImage = imcomplement(im2double(img)) ;
testImage = testImage(2:end - 60,3: end - 3);
VerticalScan = sum( testImage()) ;

[xMin,xMax] = findMinMaxArray(VerticalScan);
HorizontalScan = (sum( testImage,2 ))' ;

[yMin,yMax] = findMinMaxArray(HorizontalScan);


for i = 1 : size(xMin,2)
    for j = 1 : size(yMin,2)
        cropedImage = testImage(yMin(j):yMax(j),xMin(i):xMax(i));
        if sum(cropedImage(:)) > 5
            
            VerticalScan = sum( cropedImage()) ;

            [xMin1,xMax1] = findMinMaxArray(VerticalScan);
            HorizontalScan = (sum( cropedImage,2 ))' ;

            [yMin1,yMax1] = findMinMaxArray(HorizontalScan);
            
            cropedImageHeight = size(cropedImage,1);
            cropedImageWidth = size(cropedImage,2);
            
            f = img(yMin(j) + yMin1: yMax(j) - (cropedImageHeight - yMax1) ,xMin(i) + xMin1: xMax(i) -(cropedImageWidth - xMax1),:);
            
            
            
            %figure 
            %imshow(img(yMin(j):yMax(j),xMin(i):xMax(i),:),[])
        end
    end
end
end