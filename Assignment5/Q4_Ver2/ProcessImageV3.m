function processedImage = ProcessImageV3(gray)
     

    B = imgaussfilt(gray,2);
    level = graythresh(gray);
    processedImage = imbinarize(gray,level);
end