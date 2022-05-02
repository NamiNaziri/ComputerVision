function [imageCell,Dataset] = LoadDataSet(ImageDatasetPath)

s = dir(ImageDatasetPath);

imageCell = cell(5,8);

k = 1;
for i=1:numel(s)
    if s(i).isdir == 0
        I = imread([ImageDatasetPath s(i).name]);
        
        if(~isempty(strfind(s(i).name,'Patch')) && isempty(strfind(s(i).name,'Patches')))
            Dataset{k,1} = s(i).name;
            Dataset{k,2} = I;
            k = k +1;
        end
        
        if(strfind(s(i).name,'Corner'))
            rc = strfind(s(i).name,'_');
            dot = strfind(s(i).name,'.');
            row = str2num(s(i).name(rc(1) + 1 : rc(2) - 1));
            column = str2num(s(i).name(rc(2) + 1 : dot - 1));
            imageCell{row,column} = I;
            
        end
        
    end
end
end