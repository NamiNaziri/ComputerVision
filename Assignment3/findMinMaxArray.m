function [Min,Max] = findMinMaxArray(scanVector)
MinCounter = 1;
MaxCounter = 1;
foundxMin = false;

for i=1 : size(scanVector,2)
    if(~foundxMin)
        if scanVector(i) > 0.1
          Min(MinCounter) = i;
          MinCounter = MinCounter + 1;
          foundxMin = true;
        end
    else
        if scanVector(i) < 0.1
            Max(MaxCounter) = i;
            MaxCounter = MaxCounter +1;
            foundxMin = false;
        end
    end
end

end