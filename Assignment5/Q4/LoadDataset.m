function Dataset = LoadDataset(path)

s = dir(path);
k = 1;
for i=1:numel(s)
    if s(i).isdir == 0
        I = imread([path s(i).name]);
        Dataset{k,1} = s(i).name;
        Dataset{k,2} = I;
        k = k +1;
        
    end
end

end