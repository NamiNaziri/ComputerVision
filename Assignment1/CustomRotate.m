function output = CustomRotate(im, angle)
    
    % Calculate width and height of the image
    width = size(im,1);
    height = size(im,2);
    
    % Create rotation matrix
    c = cos(deg2rad(angle));
    s = sin(deg2rad(angle));

    R = [c -s;s c];

    % Calculate bounding box of the rotated recangle (picture)
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

    % New height and width based on the bounding box
    newHeight = maxY - minY + 1;
    newWidth = maxX - minX + 1;

    % buffer for the rotated image
    NewRotatedImage = zeros( newWidth, newHeight, 3);
    
    % Create matrix of the negate of the angle
    c = cos(deg2rad(-angle));
    s = sin(deg2rad(-angle));

    R = [c -s;s c];

    for i=1 : double(newWidth)
        for j=1 :  double(newHeight)
            NewPos = round( R * transpose([double(i + minX -1),double(j +minY -1)]));
            NewPos = transpose(int16(NewPos));
            if(NewPos(1) > 0 && NewPos(2)>0 && NewPos(1)<=width && NewPos(2)<= height)
                NewRotatedImage(i,j,1) = im(NewPos(1) ,NewPos(2) ,1);
                NewRotatedImage(i,j,2) = im(NewPos(1) ,NewPos(2) ,2);
                NewRotatedImage(i,j,3) = im(NewPos(1) ,NewPos(2) ,3);
            end

        end
    end
    
    output = uint8(NewRotatedImage);
end