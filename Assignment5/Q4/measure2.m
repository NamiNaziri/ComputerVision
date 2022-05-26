function [Se, Sp, Acc] = measure2(final, GT,mask)

NotVessel = ~GT;
NotFinal = ~final;

TNImage = (NotVessel& NotFinal);
TNImage(~mask) = 0;
FPImage = (NotVessel& final);
FPImage(~mask) = 0;
TPImage =  (GT & final);
TPImage(~mask) = 0;
FNImage = logical(GT) - TPImage;
FNImage(~mask) = 0;


FN = sum(FNImage(:));
TP = sum(TPImage(:));
FP = sum(FPImage(:));
TN = sum(TNImage(:));

Se = TP / (TP+FN) * 100;
Sp = TN / (TN+FP) * 100;
Acc = (TP + TN) / (TP+TN+FP+FN) *100;

end