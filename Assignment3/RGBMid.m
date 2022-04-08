function out = RGBMid(I)
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    out1(:,:) = medfilt2(R,[2,2]);
    out2(:,:) = medfilt2(B,[2,2]);
    out = out1 + out2;
end