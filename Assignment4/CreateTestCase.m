function [] = CreateTestCase(inputPath,outputPath)

    img = imread(inputPath);
    srcWidth = 1920;
    srcHeight = 1200;
    lastRow = srcHeight / 120;
    lastColumn = srcWidth / 120;
    test = struct;
    k = 1;
    for i=1:lastRow
        for j=1:lastColumn
            if((i == 1 && j == 1) || (i==lastRow && j==1) || (i == 1 && j == lastColumn) || (i==lastRow && j == lastColumn))
                imwrite(img((120*(i-1)) + 1:120*(i-1)+120,(120*(j-1)) + 1:120*(j-1)+120,:),[outputPath,'Corner_',num2str(i),'_',num2str(j),'.jpg'])
            else
                test(k).img = img((120*(i-1)) + 1:120*(i-1)+120,(120*(j-1)) + 1:120*(j-1)+120,:);
                k = k + 1;
            end

        end
    end
    test = test(randperm(numel(test)));

    for i=1:size(test,2)
        imwrite(test(i).img,[outputPath,'Patch_',num2str(i),'.jpg'])
    end
end