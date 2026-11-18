% Naive Bayes Classifier


close all
clear 
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% number of datapoints - dont use too many samplespoints of computation 
% will be excessive!
testingSamples = 10000;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate 2 cluster Gaussian dataset
%1. Generate training and testing datasets

% set mean and covariance for class 0
Mean1 = [3; -1;];
%Sigma1 = [0.5 .9; 0.9 10;];
Sigma1 = [2 4; 4 10];
% set mean and covariance for class 1
Mean2 = [-3; -1;];
%Sigma2 =[0.5 .9; .9 12];
 Sigma2 = [2 4; 4 10];  
   
% generate traininig dataset
trainingSamples = 10000;
[trainingData, trainingTarget] = GenerateGaussianData(trainingSamples, Mean1, Sigma1, Mean2, Sigma2);

% generate testing dataset
testingSamples = 10000;
[testingData, testingTarget] = GenerateGaussianData(testingSamples, Mean1, Sigma1, Mean2, Sigma2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pick max output to get class
trainingClass = CollapseBinaryVectorToClass(trainingTarget);
% plot the two classes of the training dataset
PlotTwoClasses(trainingData, trainingClass, 'Input training data')
title('Input training data');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get datasets

% decode  class 0
fidx_0 = find(trainingClass==0);
S.cA_data = trainingData(:,fidx_0);

% decode  class 1
fidx_1 = find(trainingClass==1);
S.cB_data = trainingData(:,fidx_1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% estimate naieve Bayes parameters
% 2. Estimate the naïve Bayes classifier sufficient statistics

% mean and marginal stds of class 0
S.MeanEstA(1) = nanmean(S.cA_data(1,:));
S.MeanEstA(2) = nanmean(S.cA_data(2,:));
S.StdEstA(1) = sqrt( nanvar(S.cA_data(1,:)) );
S.StdEstA(2) = sqrt( nanvar(S.cA_data(2,:)) );

% mean and marginal stds of class 1
S.MeanEstB(1) = nanmean(S.cB_data(1,:));
S.MeanEstB(2) = nanmean(S.cB_data(2,:));
S.StdEstB(1) = sqrt( nanvar(S.cB_data(1,:)) );
S.StdEstB(2) = sqrt( nanvar(S.cB_data(2,:)) );

% priors
S.P_A = length(S.cA_data)/length(trainingData);
S.P_B = length(S.cB_data)/length(trainingData);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%3. Reconstruct the training data

% now reconstruct class 1 mean and signma2 using naieve bayes assumption
MeanR1(1,1) = S.MeanEstA(1);
MeanR1(2,1) = S.MeanEstA(2);
SigmaR1(1,1) = S.StdEstA(1)^2;
SigmaR1(1,2) = 0;
SigmaR1(2,1) = 0;
SigmaR1(2,2) = S.StdEstA(2)^2;
% now reconstruct class 2 mean and signma2 using naieve bayes assumption
MeanR2(1,1) = S.MeanEstB(1);
MeanR2(2,1) = S.MeanEstB(2);
SigmaR2(1,1) = S.StdEstB(1)^2;
SigmaR2(1,2) = 0;
SigmaR2(2,1) = 0;
SigmaR2(2,2) = S.StdEstB(2)^2;

% sampple from this independent distrubution
[reconstructedData, reconstuctedTarget] = GenerateGaussianData(testingSamples, MeanR1, SigmaR1, MeanR2, SigmaR2);

% pick max output to get class
reconstructedClass = CollapseBinaryVectorToClass(reconstuctedTarget);
% plot the two classes of the training dataset
PlotTwoClasses(reconstructedData, reconstructedClass, 'Reconstructed naieve bayes Input training data')
title('Reconstructed naieve bayes Input training data');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% run recognition on testing dataset
% 4. Implement a naïve Bayes classifier
% 5. Run the naïve Bayes classifier on the test data and plot the results

% testing data
data = testingData;

% calculate P(x|a) and P(x|b) by putting values into Gauss function
P_x_Given_A =  Gauss1D(data(1,:), S.MeanEstA(1), S.StdEstA(1)) .*  Gauss1D(data(2,:), S.MeanEstA(2), S.StdEstA(2));
P_x_Given_B =  Gauss1D(data(1,:), S.MeanEstB(1), S.StdEstB(1)) .*  Gauss1D(data(2,:), S.MeanEstB(2), S.StdEstB(2));

% calculate P(a|x) and P(b|x) by using Bayes rule
P_A_Given_x = P_x_Given_A * S.P_A ./(P_x_Given_A * S.P_A + P_x_Given_B * S.P_B);
P_B_Given_x = P_x_Given_B * S.P_B ./(P_x_Given_A * S.P_A + P_x_Given_B * S.P_B);

% call associations to simply notaion
a = P_A_Given_x;
b = P_B_Given_x;

% allocate data to most likely class
testingClass = zeros(1,length(data));
aidx = find (a > b);
bidx = find (b >= a);

%  set class
testingClass(aidx) = 0;
testingClass(bidx) = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot the two classes of the testing dataset
PlotTwoClasses(data, testingClass, 'Recognized on testing data')
title('Recognized on testing data')





