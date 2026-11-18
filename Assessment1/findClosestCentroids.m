%assign each point to the nearest cluster
function idx= findClosestCentroids(X,centroids)
%count the number of data points
N= size(X, 1);

%store the nearest centroid index
idx =zeros(N, 1);

%loop for each data point
for i=1:N

    %calculate the distance to every centroid
    distances =sqrt ((centroids(:,1)- X(i,1)).^2 + (centroids(:,2)- X(i,2)).^2);
    %find nearest centroid
    [~, closestCentroid] = min(distances);
    idx(i) = closestCentroid;
end
end