function tmpResult = findNeighbours(B, tmpResult,i,j, cellCount)

    if(i-1 > 1) % i-1 , j
        if(B(i-1,j) ~= 0)
            if( tmpResult(i-1,j) == 0 )
                tmpResult(i-1,j) = cellCount;
                findNeighbours(B,tmpresult,i-1,j,cellCount);
            else
                return;
            end
            
        end
    else
        return;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
   if(i-1 > 1 && j-1 > 1) % i-1 , j - 1
        if(B(i-1,j-1) ~= 0)
            if( tmpResult(i-1,j-1) == 0 )
                tmpResult(i-1,j-1) = cellCount;
                findNeighbours(B,tmpresult,i-1,j-1,cellCount);
            else
                return;
            end
            
        end
    else
        return;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if(i-1 > 1 && j+1 < size(B,2)) % i-1 , j+1
        if(B(i-1,j+1) ~= 0)
            if( tmpResult(i-1,j+1) == 0 )
                tmpResult(i-1,j+1) = cellCount;
                findNeighbours(B,tmpresult,i-1,j+1,cellCount);
            else
                return;
            end
            
        end
    else
        return;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if(j-1 > 1) %i , j -1 
        if(B(i,j-1) ~= 0)
            if( tmpResult(i,j-1) == 0 )
                tmpResult(i,j-1) = cellCount;
                findNeighbours(B,tmpresult,i,j-1,cellCount);
            else
                return;
            end
            
        end
    else
        return;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if(j + 1 <size(B,2)) % i , j + 1
        if(B(i,j+1) ~= 0)
            if( tmpResult(i,j+1) == 0 )
                tmpResult(i,j+1) = cellCount;
                findNeighbours(B,tmpresult,i,j+1,cellCount);
            else
                return;
            end
            
        end
    else
        return;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if(i+1 < size(B,1)) %i + 1 , j
        if(B(i+1,j) ~= 0)
            if( tmpResult(i+1,j) == 0 )
                tmpResult(i+1,j) = cellCount;
                findNeighbours(B,tmpresult,i+1,j,cellCount);
            else
                return;
            end
            
        end
    else
        return;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if(i+1 < size(B,1) && j - 1 > 1) % i + 1 , j - 1
        if(B(i+1,j-1)~= 0)
            if( tmpResult(i+1,j-1) == 0 )
                tmpResult(i+1,j-1) = cellCount;
                findNeighbours(B,tmpresult,i+1,j-1,cellCount);
            else
                return;
            end
            
        end
    else
        return;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if(i+1 < size(B,1) && j+1 < size(B,2)) % i + 1 , j + 1
        if(B(i+1,j+1) ~= 0)
            if( tmpResult(i+1,j+1) == 0 )
                tmpResult(i+1,j+1) = cellCount;
                findNeighbours(B,tmpresult,i+1,j+1,cellCount);
            else
                return;
            end
            
        end
    else
        return;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
end