function FoundImage = InitializeFoundImageStruct(imageCell)
    
    srcWidth = 1920;
    srcHeight = 1200;

    lastRow = srcHeight / size(imageCell{1,1},1);
    lastColumn = srcWidth / size(imageCell{1,1},2);

    FoundImage = struct('index', repmat({[]}, 1, nnz(~cellfun(@isempty,imageCell))));
    k = 1;
    for i=1:lastRow
        for j=1:lastColumn
            if(~isempty(imageCell{i,j}))
                FoundImage(k).row =  i;
                FoundImage(k).Column =  j;
                img = imageCell{i,j};
                
                [Top,Left,Right,Bottom] = ExtractFeaturesForEdges(img);
                
                FoundImage(k).Top =  Top;
                FoundImage(k).Bottom =  Bottom;
                FoundImage(k).Left =  Left;
                FoundImage(k).Right =  Right;

                k = k +1;
            end
        end
    end
end