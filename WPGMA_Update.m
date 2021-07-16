function updatedMat = WPGMA_Update(distanceMat, row, col)
    
    m = size(distanceMat,1);
    distanceMat = cat(1,distanceMat,zeros(1,m));
    distanceMat = cat(2,distanceMat,zeros(m+1,1));
    updatedMat = distanceMat;
    
    updatedMat(m+1,:) = 1/2 * (distanceMat(row,:) + distanceMat(col,:));
    updatedMat(:,m+1) = 1/2 * (distanceMat(:,row) + distanceMat(:,col));
    
    updatedMat(:,[row,col]) = [];
    updatedMat([row,col],:) = [];
end