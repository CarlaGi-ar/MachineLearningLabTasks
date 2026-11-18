%calculating the Within-Cluster Sum of Squares

function totalDistance = calculateWCSS(X, idx, centroids)

%finding the assigned centroid for each data point
assignedCentroids = centroids(idx, :);

%calculating the difference between points and centroids
differences = X - assignedCentroids;

%Square the differences
squaredDifferences = differences.^2;

%Add all squared distances
totalDistance = sum(squaredDifferences(:));

end
