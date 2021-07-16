function clusters = CorrelationClustering(data , Method , clustersNum)
    %Correlation Coefficient Matrix
    CorrMat = CorrCoefMat(data);

    %defining a distance measure
    distanceMeasure = 1 - CorrMat;
    distanceMeasure(distanceMeasure < 1e-5) = 0;
    
    %Clustering the data
    currentClusterNum = size(distanceMeasure,1);
    clusters = cell(1,currentClusterNum);
    for i=1:length(clusters)
        clusters{i} = i;
    end
    tmpDistance = distanceMeasure;
    
    while (currentClusterNum ~= clustersNum)
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

