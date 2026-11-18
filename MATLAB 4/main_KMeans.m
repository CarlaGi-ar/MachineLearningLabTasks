close all;
clear;
clc;

%generated a 2D dataset with 2 slightly overlapping clustered 
%each cluster has 1000 point each

N=1000;

%dataset 1
mean1=[-4 -1];
std1= 0.75;

cluster1= randn(N,2)*std1+mean1;

%dataset 2
mean2=[3 4];
std2=2.00;

cluster2= randn(N,2)* std2+mean2;

%plot the datasets

figure;
hold on;

plot(cluster1(:,1), cluster1(:,2),'b.','MarkerSize',10);
plot(cluster2(:,1), cluster2(:,2), 'r.', 'MarkerSize',10);
legend('Dataset 1', 'Dataset 2');
xlabel('x-value');
ylabel('y-value');
title('Original Dataset', 'FontSize',12);
grid on;
hold off;

%joining both data into a single colour dataset
TrainData=[cluster1; cluster2];

%plot  into a figure
PlotConcatenateDatase(TrainData);