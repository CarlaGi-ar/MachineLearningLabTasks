close all;
clear;
clc;

%load data
load('..\Data\ovariancancer.mat');

obs= (obs -mean(obs)) ./ std(obs);

[coeff, score, latent, ~, explained] = pca(obs);

%plot cancer vs normal
idxcancer = find(strcmp(grp, 'Cancer')); %strcmp checks each label and find gives the row numbers
idxnormal = find(strcmp(grp, 'Normal'));
x = score(idxcancer, 1); 
y = score(idxcancer, 2); 
plot(x,y,'rx'); hold on; 
x = score(idxnormal, 1); 
y = score(idxnormal, 2); 
plot(x,y,'bo'); xlabel('PC1'); ylabel('PC2'); 
legend('Cancer' , 'Normal'); 