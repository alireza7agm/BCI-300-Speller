function clusters = CorrClustering(distanceMeasure, numClusters , Method)
    currentClusterNum = 63;
    clusters = cell(1,63);
    for i=1:63
        clusters{i} = i;
    end
    tmpDistance = distanceMeasure;
    
    while (currentClusterNum ~= numClusters)
        distVals = unique(tmpDistance(:));
        leastDist = distVals(2);
        ind = find(tmpDistance == leastDist);
        [row,col] = ind2sub(size(tmpDistance),ind(1));
        
        if strcmp(Method, 'UPGMA') == 1
            tmpDistance = UPGMA_Update(tmpDistance, row, col , clusters);
        elseif strcmp(Method, 'WPGMA') == 1
            tmpDistance = WPGMA_Update(tmpDistance, row, col);
        else
            error('Undefined Clustering Method');
        end
        
        clusters{end+1} = [cell2mat(clusters(row)),cell2mat(clusters(col))];
        clusters([row,col]) = [];
        
        currentClusterNum = currentClusterNum - 1;
    end
end