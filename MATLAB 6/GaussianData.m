%generated 2D Gaussian Data to demonstrated PCA
close all;
clear;
clc;
rng(1);
%generate 1000 observations with 2 features and covariance between them
samples =1000;
mean=[0; 0];
Covariance=[3 4; 4 8];

dataN= randn(2, samples);%generated 2 rows of 1000 columns

dataC= chol(Covariance)'*dataN+repmat(mean, 1, samples);%data correlated 
dataC=dataC';%transports the matrix with swamping the rows and columns , turn the table side way so pca can read it

%Using pca function
[coeff, score, latent]= pca(dataC);
%note for me When you call pca(dataC), MATLAB automatically calculates both PC1 and PC2, because your dataset has two features.
%Look at your Workspace: latent =[10.7444;0.8193]; PC1= 10.7444; 

dataReconst= score*coeff'; %reconstructed to original data
plot(dataReconst(:,1), dataReconst(:,2), 'bo');

%visualizing the data from PCA's point of view
figure;
plot(score(:,1), score(:,2), 'ro');
axis equal;
xlabel('PC1');
ylabel('PC2');
title('Data in Principal Component Space');

%visualizing PC1 and PC2 in the same graph
figure(1);
hold on;
quiver (0, 0, 3*sqrt(latent(1))*coeff(1,1),3*sqrt(latent(1))*coeff(2,1),'r', 'LineWidth',2);
quiver(0, 0, 3*sqrt(latent(2))*coeff(1,2),3*sqrt(latent(2))*coeff(2,2), 'g', 'LineWidth', 2);
axis equal;
legend('Data','PC1', 'PC2');
title('Principal Components');