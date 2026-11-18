close all
clear
clc

% Generate 100 sample points using the equation for a 1D line
% creating 3 variables
N=100;
m=1.6;
c=6;

x= linspace(-4,6, N);
yTrue= m*x+c;

%Add Gaussian noise to the data with mean 0 and std 1
y=yTrue+randn(1,N);

%plot y against the sample number
figure
plot(x, y, 'b - o')


%add labels
xlabel('Data point number'), ylabel('Data point value'), title('Raw noisy line data plot');
legend('raw data')
grid on 