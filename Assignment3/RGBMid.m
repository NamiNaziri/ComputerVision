function out = RGBMid(I)
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    out(:,:,1) = medfilt2(R,[2,2]);
    out(:,:,2) = medfilt2(G,[2,2]);
    out(:,:,3) = medfilt2(B,[2,2]);
end