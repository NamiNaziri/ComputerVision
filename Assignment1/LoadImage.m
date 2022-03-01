function [output,width,height]= LoadImage(path)
    F = fopen(path);
ImageRawData = fread(F,inf,'uint8=>char')';

%Finding white spaces indices
Header = find(isspace(ImageRawData),4);

%calculate width and height of the image
height = str2num(ImageRawData(uint8(Header(1)):uint8(Header(2))));
width = str2num(ImageRawData(uint8(Header(2)):uint8(Header(3))));

%Separate data from headers
ImageData = ImageRawData(Header(4) + 1:end);

% Create RGB array of image
RGBImageData = zeros( width, height, 3);

% Fill the RGB array
counter = 1;
for i=1 : width
    for j=1 : height
        for k = 1 : 3
            RGBImageData(i,j,k) = ImageData(counter);
            counter = counter + 1;
        end
    end
end
    output = uint8(RGBImageData);
end