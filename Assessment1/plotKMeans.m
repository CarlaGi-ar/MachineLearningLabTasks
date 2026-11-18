%plot K-means clustering results
function plotKMeans(data, clusterLabels, centroids, K)
figure;
hold on;

%plot 5 clusters using the same colours
colors={'b','y','g', 'm', 'c'};
for j= 1:K
    clusterPoints = data(clusterLabels == j, :);
    scatter(clusterPoints(:, 1), clusterPoints(:, 2), 36, colors{j}, 'filled');
end

%plot cluster centroids
plot(centroids(:,1), centroids(:,2), 'kx', 'MarkerSize', 12, 'LineWidth', 3);

xlabel('X-values');
ylabel('Y-values');
title('K-means Clustering Results');
legend('Cluster1', 'Cluster2', 'Cluster3', 'Cluster4', 'Cluster5', 'Centroids');
axis equal;
grid on;
hold off;
