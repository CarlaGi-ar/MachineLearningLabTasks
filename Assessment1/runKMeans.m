%the function loop that repeats until convergence 

function [idx, centroids]=runKMeans(X,K)

%random centroids
centroids = initCentroids(X, K);

%repeat unlit maximum iterations
maxIterarions =100;

for iteration = 1:maxIterarions

    %assigning points to nearest centroids
    idx= findClosestCentroids(X, centroids);

    %calculating the new centroids
    updatedCentroids= newCentroids(X, idx, K);

    if isequal(updatedCentroids, centroids)
        break;
    end

    centroids = updatedCentroids;
end
%assigning points using final centroids
idx = findClosestCentroids(X, centroids);
