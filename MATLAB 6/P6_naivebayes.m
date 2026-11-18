close all;
clear;
clc;

load('..\Data\fisheriris.mat');
X = meas(:, 3:4);
Y = species;
tabulate (Y)

%train model using fitcnb
Mdl = fitcnb(X, Y, 'ClassNames',{'setosa','versicolor','virginica'})
%The model is trained! It has 150 observations, 3 classes, and {'normal' 'normal'}, so it fitted a bell curve to each of the 2 features.
%DistributionParameters: {3×2 cell} is where it stores what it learned:
%3 rows = the 3 flower types
%2 columns = the 2 features (petal length, petal width)
%each box holds a mean and a std

%peek inside setosa's pedal  lenght

setosaIndex = strcmp(Mdl.ClassNames,'setosa'); 
estimates = Mdl.DistributionParameters{setosaIndex,1};
%The mean is 1.4620 and the standard deviation is 0.1737. 

%Plot the Gaussian contours
figure 
gscatter(X(:,1),X(:,2),Y);%gscatter draws the 150 flowers, colored by type.
h = gca; 
cxlim = h.XLim; 
cylim = h.YLim; 
hold on 
Params = cell2mat(Mdl.DistributionParameters);  
Mu = Params(2*(1:3)-1,1:2); % Extract the means 
Sigma = zeros(2,2,3); %Params / Mu / Sigma take the means and stds the model learned (the 3×2 boxes) out of the model.
%create the for loop draws an oval "contour" (a ring around each group) for each of the 3 types. That's the bell curve seen from above.
for j = 1:3 
    Sigma(:,:,j) = diag(Params(2*j,:)).^2; % Create diagonal covariance matrix 
    xRange = Mu(j,1) + 4*[-1 1]*sqrt(Sigma(1,1,j)); 
    yRange = Mu(j,2) + 4*[-1 1]*sqrt(Sigma(2,2,j)); 
    f = @(x,y) arrayfun(@(x0,y0) mvnpdf([x0 y0],Mu(j,:),Sigma(:,:,j)),x,y); 
    fcontour(f,[xRange yRange]) % Draw contours for the multivariate normal distributions  
end 
h.XLim = cxlim; 
h.YLim = cylim; 
title('Naive Bayes Classifier -- Fisher''s Iris Data') 
xlabel('Petal Length (cm)') 
ylabel('Petal Width (cm)') 
legend('setosa','versicolor','virginica') 
hold off