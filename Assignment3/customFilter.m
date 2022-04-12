function [finalPic] = customFilter(J,filterKernelSizeHeight, filterKernelSizeWidth)
    picHeight = size(J,1);
    picWidth = size(J,2);

    fullColorVector =[];
    colorVector = [];

    finalPic= J;

    for u=1: picHeight
        for v=1 : picWidth
            if J(u,v) == 255 || J(u,v) == 0

                for k= -floor(filterKernelSizeHeight/2) : floor(filterKernelSizeHeight/2)
                    for p= -floor(filterKernelSizeWidth/2) : floor(filterKernelSizeWidth/2)
                        if  u+k > 0 && u+k < picHeight && v+p > 0  && v+p < picWidth
                            fullColorVector(end+1)  = J(u+k, v+p);
                            if J(u+k, v+p) ~= 255 && J(u+k, v+p) ~= 0
                                colorVector(end+1) = J(u+k, v+p);
                            end
                        else
                            fullColorVector(end+1)  = 0;
                        end

                    end
                end

                if size(colorVector) ~= 0
                    finalPic(u,v) = mean(colorVector);
                else
                    finalPic(u,v) = mean(fullColorVector);
                end

                colorVector =[];
                fullColorVector = [];
            end
        end
    end
end