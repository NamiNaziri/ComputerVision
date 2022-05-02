function [Top,Left,Right,Bottom] = FindHogForEdges(img)

    Croped = img(1:size(img,1) * 0.1,:,:); %Croped Top
    features = extractHOGFeatures(Croped);
    Top =  features;

    Croped = img(size(img,1) * 0.9:end,:,:); %Croped Bottom
    features = extractHOGFeatures(Croped);
    Bottom =  features;

    Croped = img(:,size(img,2) * 0.9:end,:); %Croped Left
    features = extractHOGFeatures(Croped);
    Left =  features;

    Croped = img(:,1:size(img,2) * 0.1,:); %Croped Right
    features = extractHOGFeatures(Croped);
    Right =  features;
end