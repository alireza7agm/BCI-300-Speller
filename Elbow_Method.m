function SSE = Elbow_Method(data, Method)
    
    SSE = zeros(1,size(data,1));
    for k=1:size(data,1)
        clusters = CorrelationClustering(data, Method, k);
        SSEtotal = 0;
        for i=1:k
            clusterData = data(clusters{i},:);
            Centeroid = mean(clusterData,1);
            tmp = (clusterData-Centeroid).^2;
            SSEcluster = mean(sum(tmp, 2)); %Sum of Squared Errors
            SSEtotal = SSEtotal+size(clusterData,1)*SSEcluster;
        end
        SSE(k) = SSEtotal;
    end
    
end