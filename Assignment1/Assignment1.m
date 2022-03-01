clc; close all; clear;

F = fopen('Test_01.ppm');
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

% importing the image using internal function
im = imread('Test_01.ppm');

% showing two images 

%subplot(1,2,1),imshow(im,[]),title('1');
%subplot(1,2,2),imshow(uint8(RGBImageData),[]),title('2');


% end of part 1
%=====================================================================
% create gray image
GrayImage = rgb2gray(im)


OvalHalfWidth = 200;
OvalHalfHeight = 400;

OvalHalfWidthPow2 = OvalHalfWidth * OvalHalfWidth;
OvalHalfHeightPow2 = OvalHalfHeight * OvalHalfHeight ;

DimondHalfWidth = 100;
DimondHalfHeight = 200;

for i=1 : width
    for j=1 :  height
        if  (round(((((i - (width/2))^2) / OvalHalfHeightPow2) +  (((j - (height/2))^2) / OvalHalfWidthPow2)),2) <= 1 ) & (round( abs( (i - (width/2) ) / DimondHalfHeight) + abs( (j - (height/2)) / DimondHalfWidth), 2) >= 1)
            im(i,j,1) = 255;
            im(i,j,2) = 0;
            im(i,j,3) = 0;
        end
        if  (round(((((i - (width/2))^2) / OvalHalfHeightPow2) +  (((j - (height/2))^2) / OvalHalfWidthPow2)),2) > 1 )
            im(i,j,1) = GrayImage(i,j);
            im(i,j,2) = GrayImage(i,j);
            im(i,j,3) = GrayImage(i,j);
        end
    end
end

%imshow(im,[]);
imwrite(im,'Q2.jpg','Quality',100);

% end of part 2
%=====================================================================

angle = 90;

c = cos(deg2rad(angle));
s = sin(deg2rad(angle));

R = [c -s;s c];


topLeft = [0,0];
topRight = [0, height];
bottomLeft = [width, 0];
bottomLeft = [width, height];


% Calculate bounding box
corners = [[0,0,width,width];[0,height,0,height]];
minX = 0; minY= 0;
maxX= 0; maxY= 0;
for i=1 : 4
    vec = int16(round(R * corners(:,i)));
    
    if( vec(1) < minX)
        minX = vec(1);
    end
    
    if( vec(1) > maxX)
        maxX = vec(1);
    end
    
    if( vec(2) < minY)
        minY = vec(2);
    end
    
    if( vec(2) > maxY)
        maxY = vec(2);
    end

end


newHeight = maxY - minY;
newWidth = maxX - minX;


NewRotatedImage = zeros( newWidth, newHeight, 3);
c = cos(deg2rad(-angle));
s = sin(deg2rad(-angle));

R = [c -s;s c];

for i=1 : double(newWidth)
    for j=1 :  double(newHeight)
        NewPos = round( R * transpose([double(i + minX),double(j +minY)]));
        NewPos = transpose(int16(NewPos));
        if(NewPos(1) > 0 && NewPos(2)>0 && NewPos(1)<width && NewPos(2)<height)
            NewRotatedImage(i,j,1) = im(NewPos(1) + 1,NewPos(2) + 1,1);
            NewRotatedImage(i,j,2) = im(NewPos(1)  + 1,NewPos(2)  + 1,2);
            NewRotatedImage(i,j,3) = im(NewPos(1)  + 1,NewPos(2)  + 1,3);
        end

    end
end



RotatedImage = imrotate(im, 266);
%imshow((uint8(NewRotatedImage)),[]);
c1 = RotatedImage(:,:,1);
c2 = NewRotatedImage(:,:,1);

subplot(1,2,1),imshow(RotatedImage,[]),title('rotated by imrotate');
subplot(1,2,2),imshow(uint8(NewRotatedImage),[]),title('2');

imwrite(uint8(NewRotatedImage),'Q3.png');


