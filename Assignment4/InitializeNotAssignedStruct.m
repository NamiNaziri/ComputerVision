function NotAssigned = InitializeNotAssignedStruct(Dataset)
    NotAssigned = struct('index', repmat({[]}, 1, size(Dataset,1)));
    k = 1;
    
    for i=1:size(Dataset,1)
        img = Dataset{i,2};
        NotAssigned(k).img = img;
        [Top,Left,Right,Bottom] = ExtractFeaturesForEdges(img);
        NotAssigned(k).Top =  Top;
        NotAssigned(k).Bottom =  Bottom;
        NotAssigned(k).Left =  Left;
        NotAssigned(k).Right =  Right;

        k = k +1;
    end
end