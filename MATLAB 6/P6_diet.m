%PCA practical example 1
%National Health and Nutrition Examination Survey (NHANES) dataset 
close all;
clear;
clc;

%load data file
data= load('..\Data\dietdata_small.csv');
size(data);
data = (data -mean(data, 'omitnan')) ./ std(data, 'omitnan');%center each column around 0
%make each column's spread 1 
% skip missing values 'nanmean'

%run pca function
[~, score, latent, ~, explained] = pca(data,'Rows','pairwise');%coeff and tsquared replaced with ~, means I don't need it skip this output

%plot figure 
figure;
bar(latent, 'b');%latent has 47 rows
xlabel('Principal Component');
ylabel('Variance latent');
title('PCA Eigenvalues');
grid on;

%plot information kept curve
figure;
plot(cumsum(explained), 'k-o');
xlabel('Number of Principal Components');
ylabel('Cumulative information (%)');
title('Cumulative Explained Variance'); grid on;

%plot data in PC space 
figure;
scatter(score(:,1), score(:,2), 10, 'b', 'filled');
xlabel('PC1'); ylabel('PC2');
title('Diet data: PC1 vs PC2'); 
grid on;

%plot data in 3D view
figure;
plot3(score(:,1), score(:,2), score(:,3), 'bo');
xlabel('PC1'); ylabel('PC2'); zlabel('PC3');
title('Diet data: first 3 PCs'); 
grid on;