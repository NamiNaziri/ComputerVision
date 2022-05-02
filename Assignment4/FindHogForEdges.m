function [Top,Left,Right,Bottom] = FindHogForEdges(img)
    

    numOfPixle = 3;
    Croped = img(1:numOfPixle,:,:); %Croped Top
    
    R=single(transpose(imhist(Croped(:,:,1))));
    G=single(transpose(imhist(Croped(:,:,2))));
    B=single(transpose(imhist(Croped(:,:,3))));
    
    features1 = extractHOGFeatures(Croped);
    features2 = extractLBPFeatures(rgb2gray(Croped));
    features = [features1 features2 R G B single(transpose(Croped(:)))];
    Top =  features;

    Croped = img(size(img,1) - numOfPixle +1 :end,:,:); %Croped Bottom
    
    
    R=single(transpose(imhist(Croped(:,:,1))));
    G=single(transpose(imhist(Croped(:,:,2))));
    B=single(transpose(imhist(Croped(:,:,3))));
    
    features1 = extractHOGFeatures(Croped);
    features2 = extractLBPFeatures(rgb2gray(Croped));
    features = [features1 features2 R G B single(transpose(Croped(:)))];
    
    Bottom =  features;

    Croped = img(:,size(img,2) - numOfPixle +1:end,:); %Croped Right
   
    
    R=single(transpose(imhist(Croped(:,:,1))));
    G=single(transpose(imhist(Croped(:,:,2))));
    B=single(transpose(imhist(Croped(:,:,3))));
    
    features1 = extractHOGFeatures(Croped);
    features2 = extractLBPFeatures(rgb2gray(Croped));
    features = [features1 features2 R G B single(transpose(Croped(:)))];
    
    Right =  features;

    Croped = img(:,1:numOfPixle,:); %Croped Left
    
    
    R=single(transpose(imhist(Croped(:,:,1))));
    G=single(transpose(imhist(Croped(:,:,2))));
    B=single(transpose(imhist(Croped(:,:,3))));
    
    features1 = extractHOGFeatures(Croped);
    features2 = extractLBPFeatures(rgb2gray(Croped));
    features = [features1 features2 R G B single(transpose(Croped(:)))];
    
    Left =  features;
end