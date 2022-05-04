function [Top,Left,Right,Bottom] = ExtractFeaturesForEdges(img)
    

    numOfPixle = 1;
    Croped = img(1:numOfPixle,:,:); %Croped Top
    
    sumR = mean(Croped(:,:,1));
    sumG = mean(Croped(:,:,2));
    sumB = mean(Croped(:,:,3));
    R=single(transpose(imhist(Croped(:,:,1))));
    G=single(transpose(imhist(Croped(:,:,2))));
    B=single(transpose(imhist(Croped(:,:,3))));
    
    %features1 = extractHOGFeatures(Croped);
    %features2 = extractLBPFeatures(rgb2gray(Croped));
    features = [R G B single(transpose(Croped(:)))];
    Top =  features;

    Croped = img(size(img,1) - numOfPixle +1 :end,:,:); %Croped Bottom
    
        sumR = mean(Croped(:,:,1));
    sumG = mean(Croped(:,:,2));
    sumB = mean(Croped(:,:,3));
    R=single(transpose(imhist(Croped(:,:,1))));
    G=single(transpose(imhist(Croped(:,:,2))));
    B=single(transpose(imhist(Croped(:,:,3))));
    
    %features1 = extractHOGFeatures(Croped);
    %features2 = extractLBPFeatures(rgb2gray(Croped));
    features = [R G B  single(transpose(Croped(:)))];
    
    Bottom =  features;

    Croped = img(:,size(img,2) - numOfPixle +1:end,:); %Croped Right
   
        sumR = mean(Croped(:,:,1));
    sumG = mean(Croped(:,:,2));
    sumB = mean(Croped(:,:,3));
    R=single(transpose(imhist(Croped(:,:,1))));
    G=single(transpose(imhist(Croped(:,:,2))));
    B=single(transpose(imhist(Croped(:,:,3))));
    
    %features1 = extractHOGFeatures(Croped);
    %features2 = extractLBPFeatures(rgb2gray(Croped));
    features = [R G B   single(transpose(Croped(:)))];
    
    Right =  features;

    Croped = img(:,1:numOfPixle,:); %Croped Left
    
        sumR = mean(Croped(:,:,1));
    sumG = mean(Croped(:,:,2));
    sumB = mean(Croped(:,:,3));
    R=single(transpose(imhist(Croped(:,:,1))));
    G=single(transpose(imhist(Croped(:,:,2))));
    B=single(transpose(imhist(Croped(:,:,3))));
    
    %features1 = extractHOGFeatures(Croped);
    %features2 = extractLBPFeatures(rgb2gray(Croped));
    features = [R G B  single(transpose(Croped(:)))];
    
    Left =  features;
end