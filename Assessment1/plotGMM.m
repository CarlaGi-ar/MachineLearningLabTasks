function plotGMM(X, idxGMM, gm)

% Plot GMM clusters
figure;
gscatter(X(:,1), X(:,2), idxGMM);
hold on;

% Plot estimated Gaussian means
plot(gm.mu(:,1), gm.mu(:,2),'kx', 'MarkerSize', 12, 'LineWidth', 3);

xlabel('X-values');
ylabel('Y-values');
title('GMM Clustering Results (K = 5)');
legend('Cluster 1', 'Cluster 2', 'Cluster 3','Cluster 4', 'Cluster 5', 'GMM Means');

axis equal;
grid on;
hold off;

end
