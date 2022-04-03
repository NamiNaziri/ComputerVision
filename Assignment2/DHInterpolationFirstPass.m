function [resizedImage] = DHInterpolationFirstPass(im)

    height = size(im,1);
    width = size(im,2);

resizedImage = uint8(zeros( ceil(height * 2) ,  ceil(width * 2), size(im,3)));

resizedHeight = size(resizedImage,1);
resizedWidth = size(resizedImage,2);

for i=1 : resizedHeight
    for j=1 : resizedWidth
        if mod((j-1), 2) == 1
            if mod((i-1), 2) == 1

                resizedImage(i,j,:) = (double(im((i)/2,(j)/2,:)));
            else
                resizedImage(i,j,:) = zeros(1,1,size(im,3));
            end
            
            
        end
    end
end


for i=1 : resizedHeight
    for j=1 : resizedWidth
        
        if mod(i, 2) == 1
            if mod(j,2) == 1

                top = min(max(floor(i-1),1),resizedHeight);
                bottom = min(max(ceil(i+1),1),resizedHeight);
                left = min(max(floor(j-1),1),resizedWidth);
                right = min(max(ceil(j+1),1),resizedWidth);

                topLeftPixle = double(resizedImage(top,left,:));
                topRightPixle = double(resizedImage(top,right,:));
                bottomRightPixle = double(resizedImage(bottom,right,:));
                bottomLeftPixle = double(resizedImage(bottom,left,:));

                resizedImage(i,j,:) = (topLeftPixle + topRightPixle + bottomRightPixle + bottomLeftPixle) /4;
            end
        end

    end
end

for i=1 : resizedHeight
    for j=1 : resizedWidth
        
        if mod(i, 2) == 0 % i is even
            if mod(j,2) == 1 % j is odd

                top = min(max(floor(i-1),1),resizedHeight);
                bottom = min(max(ceil(i+1),1),resizedHeight);
                left = min(max(floor(j-1),1),resizedWidth);
                right = min(max(ceil(j+1),1),resizedWidth);

                topPixle = double(resizedImage(top,j,:));
                RightPixle = double(resizedImage(i,right,:));
                bottomPixle = double(resizedImage(bottom,j,:));
                LeftPixle = double(resizedImage(i,left,:));
                if i == 2 
                    resizedImage(i,j,:) = (RightPixle + bottomPixle + LeftPixle) / 3;
                elseif i == resizedHeight || i == resizedHeight -1
                        resizedImage(i,j,:) = (RightPixle + topPixle + LeftPixle) / 3;
                else
                    resizedImage(i,j,:) = (topPixle + RightPixle + bottomPixle + LeftPixle) /4;
                end
                
            end
        end
        
        if mod(i, 2) == 1 % i is odd
            if mod(j,2) == 0 % j is even

                top = min(max(floor(i-1),1),resizedHeight);
                bottom = min(max(ceil(i+1),1),resizedHeight);
                left = min(max(floor(j-1),1),resizedWidth);
                right = min(max(ceil(j+1),1),resizedWidth);

                topPixle = double(resizedImage(top,j,:));
                RightPixle = double(resizedImage(i,right,:));
                bottomPixle = double(resizedImage(bottom,j,:));
                LeftPixle = double(resizedImage(i,left,:));
                if j == 2 
                    resizedImage(i,j,:) = (topPixle + RightPixle + bottomPixle) / 3;
                elseif j == resizedWidth || j == resizedWidth - 1
                    resizedImage(i,j,:) = (topPixle + LeftPixle + bottomPixle) / 3;
                else
                    resizedImage(i,j,:) = (topPixle + RightPixle + bottomPixle + LeftPixle) /4;
                end
                
            end
        end

    end
end

%resizedImage(resizedHeight,:,:) = resizedImage(resizedHeight-1,:,:);
%resizedImage(:,resizedWidth,:) = resizedImage(:,resizedWidth-1,:);

resizedImage(1,:,:) = resizedImage(2,:,:);
resizedImage(:,1,:) = resizedImage(:,2,:);
