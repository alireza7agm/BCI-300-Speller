function updatedMat = UPGMA_Update(distanceMat, row, col, clusters)

    m = size(distanceMat,1);
    distanceMat = cat(1,distanceMat,zeros(1,m));
    distanceMat = cat(2,distanceMat,zeros(m+1,1));
    updatedMat = distanceMat;
    
    C1 = length(clusters{row});
    C2 = length(clusters{col});
    updatedMat(m+1,:) = (C1*distanceMat(row,:) + C2*distanceMat(col,:))/(C1+C2);
    updatedMat(:,m+1) = (C1*distanceMat(:,row) + C2*distanceMat(:,col))/(C1+C2);
    
    updatedMat(:,[row,col]) = [];
    updatedMat([row,col],:) = [];
end