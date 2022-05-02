
%% second Method

clc; close all; clear;
ImageDatasetPath = 'Q3/Puzzle_2_160/';

srcWidth = 1920;
srcHeight = 1200;


[imageCell,Dataset] = LoadDataSet(ImageDatasetPath);
lastRow = srcHeight / size(imageCell{1,1},1);
lastColumn = srcWidth / size(imageCell{1,1},2);

FoundImage = InitializeFoundImageStruct(imageCell);

NotAssigned = InitializeNotAssignedStruct(Dataset);

for i=1:size(Dataset,1)
    TempPossibleAnswer = struct;
    k = 1;
    for j=1:size(NotAssigned,2)
        for u=1:lastRow
            for v=1:lastColumn

                if(isempty(imageCell{u,v}))

                    Top = NotAssigned(j).Top;
                    Bottom = NotAssigned(j).Bottom;
                    Left = NotAssigned(j).Left;
                    Right = NotAssigned(j).Right;
                    n= [];
                    if(u-1 >=  1 )
                        if(~isempty(imageCell{u-1,v})) %top here bottom other
                            [~,ib]=ismember([u-1;v].',[FoundImage.row ;FoundImage.Column].','rows');
                            if(ib ~= 0)
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
                    
                    
                    if(size(n,2) == 0)
                        finalNorm = 1000000;
                    else
                        finalNorm = mean(n);
                    end
                    TempPossibleAnswer(k).rowInFoundImage = u;
                    TempPossibleAnswer(k).ColumnInFoundImage = v; 
                    TempPossibleAnswer(k).NotAssinedIndex = j;
                    TempPossibleAnswer(k).Norm = finalNorm - 400 * size(n,2);
                    k = k + 1;
                end
            end
        end
    end
    
    
    
    %change not assigned
    
    [Cmin,minIdx] = min([TempPossibleAnswer.Norm]);
    a = TempPossibleAnswer(minIdx);
    imageCell{a.rowInFoundImage,a.ColumnInFoundImage} = NotAssigned(a.NotAssinedIndex).img;
    
    FoundImage(end+1).row =  a.rowInFoundImage;
    FoundImage(end).Column =  a.ColumnInFoundImage;
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
