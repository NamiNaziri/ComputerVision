function [FeatureDataset] = ImportDatabase(ImageDatasetPath)

    s = dir(ImageDatasetPath);

    k = 1;
    for i=1:numel(s)
        if s(i).isdir == 0
            I = imread([ImageDatasetPath s(i).name]);
            FeatureDataset{k,1} = s(i).name;
            Answer = s(i).name(find(s(i).name == '_', 1, 'last') + 1: end - 4);
            FeatureDataset{k,2} = str2num(Answer);
            FeatureDataset{k,5} = I;
            f = RGBMid(I,3);
            f = RGBMid(f,3);
            f = RGBMid(f,3);
            f = RGBMid(f,3);

            FeatureDataset{k,4} = RGBMid(f,3);

            M = repmat(all(I<10,3),[1 1 3]);
            I(M) = 255;

            H = fspecial('Average', [3,3]);
            I = imfilter(I,H);
            FeatureDataset{k,3} = imfilter(rgb2gray(I),H); 

            k = k + 1;
        end
    end
end