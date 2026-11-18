close
clear
clc

% generate 100 sample points along teh equation for a 1D quadratic lin
% quadratic coefficients
A= 1.6;
B=2.5;
C=6;
N= 100;

x=linspace(-4, 6,N);
yTrue= A*x.^2+B*x+C;

%add guassian noise mean 0 and standard deviation of 5
y=yTrue +5*randn(1,N);

%fit figure
figure;
plot(x, y, 'b o');
xlabel('Data point numer'), ylabel('Data point value'), title('Raw noisy data plot', 'FontWeight','bold')
legend('raw data')
grid on 
