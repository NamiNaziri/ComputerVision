
function [resizedImage] = DHInterpolation(im, magicNumber )
    out1 = DHInterpolationFirstPass(im);
    out2 = DHInterpolationSecondPass(im);
    resizedImage = uint8((double(out1)* (1 - magicNumber) + double(out2) * (1+magicNumber)) / 2); 