
clc; close all; clear;
inputPath = 'Q3/Test/1.jpg';
outputPath = 'Q3/Output/';

CreateTestCase(inputPath, outputPath);


% second Method

clc; close all; clear;
ImageDatasetPath = 'Q3/Output/';

srcWidth = 1920;
srcHeight = 1200;

%{
Dataset is cells of all the patches
imageCell is the cell of found images in its place on the board.
So, it's a cell consisting of rows of Max rows and columns of Max Columns
%}
[imageCell,Dataset] = LoadDataSet(ImageDatasetPath);
lastRow = srcHeight / size(imageCell{1,1},1);
lastColumn = srcWidth / size(imageCell{1,1},2);

%{

Found Image is an array of struct which consits of images that are found
and are placed on the board(imageCell).

Following are its properties
row: row of this patch in imageCell
Column: Column of this patch in image Cell
Top: The feature respecting to the top of this patch
Bottom: The feature respecting to the Bottom of this patch
Left: The feature respecting to the Left of this patch
Right: The feature respecting to the Right of this patch

%}
FoundImage = InitializeFoundImageStruct(imageCell);


%{

Not Assigned is an array of struct which consits of images that are not
assigned to the board(imageCell).

Following are its properties

img: image data of this patch
Top: The feature respecting to the top of this patch
Bottom: The feature respecting to the Bottom of this patch
Left: The feature respecting to the Left of this patch
Right: The feature respecting to the Right of this patch

%}

NotAssigned = InitializeNotAssignedStruct(Dataset);



for i=1:size(Dataset,1) %loop in the amount of number of patches..
    TempPossibleAnswer = struct;
    k = 1;
    for j=1:size(NotAssigned,2) % for each patch that is not assigned
        for u=1:lastRow  %last row of the board(ImageCell)
            for v=1:lastColumn %last Column of the board(ImageCell)
                
                if(isempty(imageCell{u,v})) % find an empty cell

                    Top = NotAssigned(j).Top;
                    Bottom = NotAssigned(j).Bottom;
                    Left = NotAssigned(j).Left;
                    Right = NotAssigned(j).Right;
                    n = [];
                    if(u-1 >= 1) 
                        %if the cell above this current empy cell is not empty
                        % find the norm between the top of this current
                        % patch and bottom of the top neighbour
                        if(~isempty(imageCell{u-1,v})) 
                            [~,ib]=ismember([u-1;v].',[FoundImage.row ;FoundImage.Column].','rows'); %finds the neighbour which is in the found image
                            if(ib ~= 0) %if exsists
                                 n(end+1) =  norm(Top - FoundImage(ib).Bottom);
                            end
                        end
                    end
                    
                    if(u+1 <= lastRow)
                        if(~isempty(imageCell{u+1,v})) %Down here Top other
                            [~,ib]=ismember([u+1;v].',[FoundImage.row ;FoundImage.Column].','rows');
                            if(ib ~= 0)
                                n(end+1) =  norm(Bottom - FoundImage(ib).Top);
                            end
                        end
                    end

                    if(v-1 >= 1)
                        if(~isempty(imageCell{u,v-1})) %Left here Right other
                            [~,ib]=ismember([u;v-1].',[FoundImage.row ;FoundImage.Column].','rows');
                            if(ib ~= 0)
                               n(end+1) =  norm(Left - FoundImage(ib).Right);
                            end
                        end
                    end
                    
                    if(v+1 <= lastColumn)
                        if(~isempty(imageCell{u,v+1})) %Right here Left other
                            [~,ib]=ismember([u;v+1].',[FoundImage.row ;FoundImage.Column].','rows');
                            if(ib ~= 0)
                                 n(end+1) =  norm(Right - FoundImage(ib).Left);
                            end
                        end
                    end
                    
                    %if there is no neighbours then give it a large norm
                    if(size(n,2) == 0) 
                        finalNorm = 1000000;
                    else
                        finalNorm = mean(n);
                    end
                    
                    %store this patch as one of the possible prospective
                    %patches
                    TempPossibleAnswer(k).rowInCellImage = u;
                    TempPossibleAnswer(k).ColumnIncCellImage = v; 
                    TempPossibleAnswer(k).NotAssinedIndex = j;
                    %if the image is sorrounded by more neighbours give it
                    %more chance to be accepted
                    TempPossibleAnswer(k).Norm = finalNorm - 750 * size(n,2); 
                    k = k + 1;
                end
            end
        end
    end
    
    
    
    %change not assigned
    %find the patch that has the least norm and place it into the
    %board(CellImage) and add it to the found image. since now the patch is
    %assigned we remove it from the NotAssigned array.
    
    [Cmin,minIdx] = min([TempPossibleAnswer.Norm]);
    a = TempPossibleAnswer(minIdx);
    imageCell{a.rowInCellImage,a.ColumnIncCellImage} = NotAssigned(a.NotAssinedIndex).img;
    
    FoundImage(end+1).row =  a.rowInCellImage;
    FoundImage(end).Column =  a.ColumnIncCellImage;
    FoundImage(end).Top =  NotAssigned(a.NotAssinedIndex).Top;
    FoundImage(end).Bottom =  NotAssigned(a.NotAssinedIndex).Bottom;
    FoundImage(end).Left =  NotAssigned(a.NotAssinedIndex).Left;
    FoundImage(end).Right =  NotAssigned(a.NotAssinedIndex).Right;
    
    NotAssigned(a.NotAssinedIndex) = []; % Since we assigned this index, we can remove it from not assigned array
    if(mod(j,10) == 0)
           out = CellToImage(imageCell);
        imshow(out)
    end

end
        
out = CellToImage(imageCell);
imshow(out)        
