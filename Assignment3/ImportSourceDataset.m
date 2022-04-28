function [SourceDataset] = ImportSourceDataset(ImageSourcePath)

s = dir(ImageSourcePath);

L = 1;
for i=1:numel(s)
    if s(i).isdir == 0
        I = imread([ImageSourcePath s(i).name]);
        SourceDataset{L,1} = s(i).name;
        
        Answer = s(i).name(find(s(i).name == '_', 1, 'last') + 1: end - 4);

        SourceDataset{L,2} = I;
        SourceDataset{L,3} = str2num(Answer);

        L = L + 1;
    end
end

end