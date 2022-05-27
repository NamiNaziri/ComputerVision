function imageCell = CreatePatches(img,patchSizeX,patchSizeY)

    srcWidth = size(img,2);
    srcHeight = size(img,1);
    lastRow =srcHeight / patchSizeY;
    lastColumn = srcWidth / patchSizeX;

    k = 1;
    for i=1:lastRow
        for j=1:lastColumn
            imageCell{i,j} = img((patchSizeY*(i-1)) + 1:patchSizeY*(i-1)+patchSizeY,(patchSizeX*(j-1)) + 1:patchSizeX*(j-1)+patchSizeX,:);
            k = k + 1;
        end
    end
   
end