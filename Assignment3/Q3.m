function [rightGuesses] = Q3()

    ImageDatasetPath = 'Questions/Q3/';

    FeatureDataset = ImportDatabase(ImageDatasetPath);
    ImageSourcePath = 'Questions/Numbers/';
    SourceDataset = ImportSourceDataset(ImageSourcePath);

    outputPath = 'Questions/Q3_Output/';

    class = 48;
    rightGuesses = 0;

    sourceWidth = 60;
    sourceHeight = 100;

    threshold1 = 100;


    for p=1 : size(FeatureDataset,1)
        testImage = imcomplement(im2double(FeatureDataset{p,3})) ;
        testImage = testImage(8:end - 60,8: end - 10);

        VerticalScan = sum( testImage()) ;
        [xMin,xMax] = findMinMaxArray(VerticalScan);

        HorizontalScan = (sum( testImage,2 ))' ;
        [yMin,yMax] = findMinMaxArray(HorizontalScan);



        finalAnswer = 0;


            for i = 1 : min(size(xMin,2),size(xMax,2))
                for j = 1 : min(size(yMin,2),size(yMax,2))
                    cropedImage = testImage(yMin(j):yMax(j),xMin(i):xMax(i));
                    if sum(cropedImage(:)) > 5
                        VerticalScan = sum( cropedImage()) ;

                        [xMin1,xMax1] = findMinMaxArray(VerticalScan);
                        HorizontalScan = (sum( cropedImage,2 ))' ;

                        [yMin1,yMax1] = findMinMaxArray(HorizontalScan);

                        cropedImageHeight = size(cropedImage,1);
                        cropedImageWidth = size(cropedImage,2);

                        f = FeatureDataset{p,4}(yMin(j) +6  + yMin1: yMax(j) + 6  - (cropedImageHeight - yMax1) ,xMin(i) +6 + xMin1: xMax(i) + 6 -(cropedImageWidth - xMax1),:);
                        %f = FeatureDataset{35,4}(yMin(j) +6:yMax(j) + 6,xMin(i) + 6:xMax(i) + 6,:);
                        f = imresize(f,[sourceHeight,sourceWidth]);

                        red = f(:,:,1);
                        blue = f(:,:,3);

                        isPositive = sum(red(:)) > sum(blue(:));

                        sign = -1;
                        if isPositive 
                            sign = 1; 
                        end


                        minError = 10000000;
                        selectedImage = 1;

                        if( abs (sum(red(:)) - sum(blue(:))) > threshold1)

                            for l = 1 : size(SourceDataset,1)
                                err = immse(rgb2gray(f), rgb2gray(SourceDataset{l,2}));
                                if(err < minError)
                                   selectedImage = l;
                                    minError = err;
                                end
                            end
                            if( p == class)
                                %figure; imshow([f SourceDataset{selectedImage,2}]);
                                %figure; imshow(f );
                                %imwrite (f,[num2str(i) num2str(j) '.png']);
                            end
                            a = sign * SourceDataset{selectedImage,3};
                            finalAnswer = finalAnswer + a;

                        end
                    end
                end
            end
        

        originalImage = FeatureDataset{p,5};
        originalImageHeight = size(originalImage,1);
        originalImageWidth = size(originalImage,2);
        
        outputImage = insertText(originalImage,[originalImageWidth/2 originalImageHeight-45],num2str(finalAnswer),'FontSize',30,'BoxColor','white','TextColor','green');    
        imwrite (outputImage,[outputPath FeatureDataset{p,1}]);
        if FeatureDataset{p,2} == finalAnswer
            rightGuesses = rightGuesses + 1;
        else
            ['Wrong Guess : ' FeatureDataset{p,1}]
        end
    end

end