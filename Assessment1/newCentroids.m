%recalculate the means of data points (new Centroids) within the clusters
function centroids =newCentroids(X, idx, K)
centroids = zeros(K, size(X, 2));
for clusterIndex = 1:K
    centroids(clusterIndex, :) = mean(X(idx == clusterIndex, :), 1);
end
end