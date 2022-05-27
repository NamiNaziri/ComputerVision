function final = ProcessOnSingleImage(image,mask,patchSizeX,patchSizeY,originalWidth,originalHeight)


       

imageCell = CreatePatches(image,patchSizeX,patchSizeY);




for i=1:size(imageCell,1)
    for j=1:size(imageCell,2)
        
        img = imageCell{i,j};

        imageCell{i,j} = ProcessImageV3(img);

    
        

    end
end

final = CalculateFinalImage(imageCell,mask,originalWidth,originalHeight);



        final = bwareaopen(final, 15);
        

end