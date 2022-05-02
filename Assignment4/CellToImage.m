function out = CellToImage(imageCell)

srcWidth = 1920;
srcHeight = 1200;
lastRow = srcHeight / size(imageCell{1,1},1);
lastColumn = srcWidth / size(imageCell{1,1},2);

    WhiteImage = im2uint8(ones(srcHeight/lastRow,  srcWidth/ lastColumn,3));
    for i=1:size(imageCell,1)
        for j=1:size(imageCell,2)
            if(isempty(imageCell{i,j}))
                imageCell{i,j} = WhiteImage;
            end
        end
    end


    out = [];
    for i=1:size(imageCell,1)
        temp = [];
        for j=1:size(imageCell,2)
            temp = cat(2,temp,imageCell{i,j});
        end
        out = cat(1,out,temp);
    end

end