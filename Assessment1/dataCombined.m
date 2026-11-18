function combinedClusters=dataCombined(cluster1, cluster2, cluster3, cluster4, cluster5)

    % Store the five clusters
    clusters = {cluster1, cluster2, cluster3, cluster4, cluster5};

    % Combine them vertically into one matrix
    combinedClusters = vertcat(clusters{:});

end
