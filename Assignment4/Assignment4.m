clc; close all; clear;
ImageDatasetPath = 'Q3/Puzzle_1_40/';

lastRow = 5;
lastColumn = 8;

[imageCell,Dataset] = LoadDataSet(ImageDatasetPath);


FoundImage = InitializeFoundImageStruct(imageCell);

NotAssigned = InitializeNotAssignedStruct(Dataset);
   
    



PredictStruct = struct; %Fields: index in NotAssigned array; row and column in image cell; hog norm;

notAssignedBottom = {NotAssigned.Bottom};
notAssignedTop = {NotAssigned.Top};
notAssignedLeft = {NotAssigned.Left};
notAssignedRight = {NotAssigned.Right};







for j=1:size(Dataset,1)
    
    PossibleAnswer = struct;
    PossibleAnswerCounter = 1;
    
    for i=1:size(FoundImage,2)
        row = FoundImage(i).row;
        Column = FoundImage(i).Column;

        k = 1;
        TempPossibleAnswer = struct;
        if(row-1 > 1) % top pic
            if(isempty(imageCell{row-1,Column}))
                %top of this pic and bottom of the other
                result = CustomNormCalculator(notAssignedBottom,{FoundImage(i).Top});
                [M,I] = min(cell2mat(result));

                TempPossibleAnswer(k).rowInFoundImage = row-1;
                TempPossibleAnswer(k).ColumnInFoundImage = Column; 
                TempPossibleAnswer(k).NotAssinedIndex = I;
                TempPossibleAnswer(k).Norm = M;
                k = k + 1;
            end
        end

        if(row + 1 < lastRow) % Bottom pic
            if(isempty(imageCell{row+1,Column}))
                %Bottom of this pic and Top of the other
                result = CustomNormCalculator(notAssignedTop,{FoundImage(i).Bottom});

                [M,I] = min(cell2mat(result));
                TempPossibleAnswer(k).rowInFoundImage = row+1;
                TempPossibleAnswer(k).ColumnInFoundImage = Column; 
                TempPossibleAnswer(k).NotAssinedIndex = I;
                TempPossibleAnswer(k).Norm = M;
                k = k + 1;
            end
        end
        if( Column - 1 > 1) % Left pic
            if(isempty(imageCell{row,Column-1}))
                %Left of this pic and Right of the other
                result = CustomNormCalculator(notAssignedRight,{FoundImage(i).Left});

                [M,I] = min(cell2mat(result));
                TempPossibleAnswer(k).rowInFoundImage = row;
                TempPossibleAnswer(k).ColumnInFoundImage = Column-1; 
                TempPossibleAnswer(k).NotAssinedIndex = I;
                TempPossibleAnswer(k).Norm = M;
                k = k + 1;
            end
        end

        if (Column + 1 < lastColumn) % Right Pic
            if(isempty(imageCell{row,Column+1}))
                %Right of this pic and Left of the other
                result = CustomNormCalculator(notAssignedLeft,{FoundImage(i).Right});


                [M,I] = min(cell2mat(result));
                TempPossibleAnswer(k).rowInFoundImage = row;
                TempPossibleAnswer(k).ColumnInFoundImage = Column+1; 
                TempPossibleAnswer(k).NotAssinedIndex = I;
                TempPossibleAnswer(k).Norm = M;
                k = k + 1;
            end
        end
        
        if(k == 1) %no neighbours found
            continue;
        end
        %Find the minimum norm for current picture
        [Cmin,minIdx]=min([TempPossibleAnswer.Norm]);

        PossibleAnswer(PossibleAnswerCounter).rowInFoundImage = TempPossibleAnswer(minIdx).rowInFoundImage;
        PossibleAnswer(PossibleAnswerCounter).ColumnInFoundImage = TempPossibleAnswer(minIdx).ColumnInFoundImage; 
        PossibleAnswer(PossibleAnswerCounter).NotAssinedIndex = TempPossibleAnswer(minIdx).NotAssinedIndex;
        PossibleAnswer(PossibleAnswerCounter).Norm = TempPossibleAnswer(minIdx).Norm;
        PossibleAnswerCounter = PossibleAnswerCounter + 1;

    end

    [Cmin,minIdx] = min([PossibleAnswer.Norm]);
    a = PossibleAnswer(minIdx);
    imageCell{a.rowInFoundImage,a.ColumnInFoundImage} = NotAssigned(a.NotAssinedIndex).img;
    
    FoundImage(end+1).row =  a.rowInFoundImage;
    FoundImage(end).Column =  a.ColumnInFoundImage;
    FoundImage(end).Top =  NotAssigned(a.NotAssinedIndex).Top;
    FoundImage(end).Bottom =  NotAssigned(a.NotAssinedIndex).Bottom;
    FoundImage(end).Left =  NotAssigned(a.NotAssinedIndex).Left;
    FoundImage(end).Right =  NotAssigned(a.NotAssinedIndex).Right;
    
    NotAssigned(a.NotAssinedIndex) = []; % Since we assigned this index, we can remove it from not assigned array
    notAssignedBottom = {NotAssigned.Bottom};
    notAssignedTop = {NotAssigned.Top};
    notAssignedLeft = {NotAssigned.Left};
    notAssignedRight = {NotAssigned.Right};
    out = CellToImage(imageCell);
    imshow(out)
    %pause;
end


