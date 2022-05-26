function final = CalculateFinalImage(imageCell,mask,originalWidth,originalHeight )

final = CellToImage(imageCell);

finalWidth = size(final,2);
finalHeight = size(final,1);


NewCol = zeros(finalHeight,uint8(originalWidth - finalWidth));
NewRow = zeros(uint8(originalHeight - finalHeight),originalWidth);

final = [final NewCol];
final = [final; NewRow];
final(~mask) = 0;
end