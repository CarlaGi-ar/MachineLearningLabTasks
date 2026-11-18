close all;
clear;
clc;

rng(10873935);

%generate a 2D dataset with 5 clusters and 2 slightly overlapping clusters
%each cluster has different  number of points between 500 and 1500
%cluster 1
N1= 1500;
mean1= [3,4];
std1 =2;

%generating the cluster's points with Gaussian (randn) and shaping them with std and mean
cluster1 = randn(N1, 2) * std1 + mean1;

%cluster 2
N2= 800;
mean2=[4, -4];
std2= 0.75;

cluster2 = randn(N2, 2) * std2 + mean2;

%cluster 3
N3= 500;
mean3=[-4.5,-4];
std3= 0.5;
cluster3 = randn(N3, 2) * std3 + mean3;

%cluster 4
N4= 1000;
mean4=[-6,5];
std4= 1;
cluster4 = randn(N4, 2) * std4 + mean4;

%cluster 5
N5 = 1200;
mean5 = [-0.5, 0];
std5 = 1.25;
cluster5 = randn(N5, 2) * std5 + mean5;

%plot cluster for visualization check

figure;
hold on;

plot(cluster1(:,1), cluster1(:,2),'b.','MarkerSize',10);
plot(cluster2(:,1), cluster2(:,2), 'y.', 'MarkerSize',10);
plot(cluster3(:,1), cluster3(:,2), 'g.', 'MarkerSize', 10);
plot(cluster4(:,1), cluster4(:,2), 'c.', 'MarkerSize', 10);
plot(cluster5(:,1), cluster5(:,2), 'r.', 'MarkerSize', 10);
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5');
xlabel('X-values');
ylabel('Y-values');
title('Generated 2D Gaussian Clusters');
axis equal;
grid on;
hold off;

% call the combined data
combinedClusters=dataCombined(cluster1, cluster2, cluster3, cluster4, cluster5);


% Visualize the combined dataset
figure;
hold on;
scatter(combinedClusters(:,1), combinedClusters(:,2), 10, 'filled');
xlabel('X-values');
ylabel('Y-values');
title('Combined Training Data');
axis equal;
grid on;
hold off;

%apply K mean to the clustering 
K = 5;
[idx, centroids] = runKMeans(combinedClusters, K);
plotKMeans(combinedClusters, idx, centroids, K);

%run WCSS  test K from 2 to 8
KValues = 2:8;

%store the WCSS result for each K
WCSSvalues = zeros(1, 7);

for K=2:8
    %run K-Means with the current K
    [idxK,  centroidsK]=runKMeans(combinedClusters, K);

    %calculate  the total squared distance
    WCSS = calculateWCSS(combinedClusters, idxK, centroidsK);

    %store the result
    WCSSvalues(K - 1) = WCSS;
end

% plot the graph
figure;
plot(KValues, WCSSvalues, '-o', 'LineWidth', 2, 'MarkerSize',8);
xlabel('Number of Clusters (K)');
ylabel('Within-Cluster Sum of Squares');
title('Elbow Method for Selecting K');
grid on;

%calculate the silhouette score
s = silhouette(combinedClusters, idx);

meanSilhouette = mean(s);
disp(meanSilhouette);

%Task 2 -GMM clustering
K_GMM =5;

[idxGMM, gm]= runGMM(combinedClusters, K_GMM);
plotGMM(combinedClusters, idxGMM,gm);

%run WCSS on GMM to compare the performance between K-Means and GMM

KValuesGMM = 2:8;

%store the WCSS result for each K
WCSSvaluesGMM = zeros(1, 7);

for K=2:8
     % Run GMM with the current K
    [GMMidxK, gmK] = runGMM(combinedClusters, K);

    % Get estimated Gaussian means
    GMMcentroidsK = gmK.mu;

    % Calculate the total squared distance
    WCSSValueGMM = calculateWCSS(combinedClusters, GMMidxK, GMMcentroidsK);

    % Store the result
    WCSSvaluesGMM(K - 1) = WCSSValueGMM;

end
% plot the graph
figure;
plot(KValuesGMM, WCSSvaluesGMM, '-o', 'LineWidth', 2, 'MarkerSize',8);
xlabel('Number of Clusters (K)');
ylabel('WCSS');
title('GMM Clustering- WCSS');
grid on;

%calculate the silhouette score for GMM
s = silhouette(combinedClusters, GMMidxK);
sGMM = silhouette(combinedClusters, idxGMM);
GMMmeanSilhouette = mean(sGMM);
disp(GMMmeanSilhouette);