function result = CustomNormCalculator(ArraysOfCells,SingleCell)
result = cell(1,size(ArraysOfCells,2));

    for u=1:size(ArraysOfCells,2)
        result{1,u} = norm(cell2mat( cellfun(@minus,ArraysOfCells(u),SingleCell,'Un',0)),2);
    end

end