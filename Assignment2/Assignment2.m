clc; close all; clear;

%im = imread('Untitled.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Question 3.b

%im = imread('Untitled.png');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Question 4

src = imread('Q5/Cameraman.png');
Inimg = imread('Q5/LR_Cameraman.png');
srcheight = size(src,1);
srcwidth = size(src,2);
%imshow(tempDes)

%psnr(tempDes,im)
% The second parameter is the magic number. by changing it we can produce
% better quality images. ofcourse based on the current sample test cases
% the magic number of 1 gives us the best quality. but 0.2 gives us almost
% best quality in every situation.
final = DHInterpolation(Inimg,0.2);

resized = imresize(Inimg,2,'Bilinear');
%imshow(uint8(final));

%psnr(uint8(resized), src)
%psnr(uint8(final), src)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Question 6
im = imread('Q6/Image.tif');

histogram = my_histogram(im);

histogram(1) = 0;
figure
bar([0:255],histogram);



J = double(imadjust(im));

%out =  255 * (1 / (J + 1));

height = size(im,1);
width = size(im,2);
out = J;
for i=1 : height
    for j=1: width
        if(J(i,j) ~= 0)
        out(i,j) =  100 * (1 / (0.1 * J(i,j) + 6));
        end
    end
end





out = zeros( height ,  width, 1);



for i=1 : height
    for j=1: width
        if  J(i,j) >= 0 && J(i,j) < 150
            
            %out(i,j) = GammaFunction(gamma, J(i,j));
        else
        end
    end
end

gamma = 0.045;
alpha = power(double(255),(1-gamma));
out = alpha* power(double(im),gamma);

out= imadjust(uint8(out),[0.8,0.95],[0,0.98]);

%
%NewPic = alphaLog * log(double(im + 1));
%NewPic = (1/alphaLog) * power(10, NewPic);


newhis = my_histogram(out );
newhis(1) = 0;
figure
bar([0:255],newhis);

figure
imshow([im uint8(out)])

