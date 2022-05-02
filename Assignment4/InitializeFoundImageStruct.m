function FoundImage = InitializeFoundImageStruct(imageCell)

    lastRow = 5;
    lastColumn = 8;

    FoundImage = struct('index', repmat({[]}, 1, nnz(~cellfun(@isempty,imageCell))));
    k = 1;
    for i=1:lastRow
        for j=1:lastColumn
            if(~isempty(imageCell{i,j}))
                FoundImage(k).row =  i;
                FoundImage(k).Column =  j;
                img = imageCell{i,j};
                
                [Top,Left,Right,Bottom] = FindHogForEdges(img);
                
                FoundImage(k).Top =  Top;
                FoundImage(k).Bottom =  Bottom;
                FoundImage(k).Left =  Left;
                FoundImage(k).Right =  Right;

                k = k +1;
            end
        end
    end
end