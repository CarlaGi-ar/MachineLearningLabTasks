close
clear
clc

% generate 100 sample points along teh equation for a 1D quadratic linregression
% quadratic coefficients
%Fit the quadratic curve using linear 

A= 1.6;
B=2.5;
C=6;
N= 100;

x=linspace(-4, 6,N);
yTrue= A*x.^2+B*x+C;

%add guassian noise mean 0 and standard deviation of 5
y=yTrue +5*randn(1,N);

% ---- 1. Build the "ingredient lists" (bases) ----
XLin  = [x; ones(1,N)];          % row 1 = x,   row 2 = 1s
XQuad = [x.*x; x; ones(1,N)];    % row 1 = x²,  row 2 = x,  row 3 = 1s

% ---- 2. Let regress find the best numbers ----
bLin  = regress(y', XLin');      % gives [slope; intercept]
bQuad = regress(y', XQuad');     % gives [A; B; C]
disp(bQuad)                      % should be close to 1.6, 2.5, 6

% ---- 3. Use those numbers to draw the fitted lines ----
yLin  = bLin'  * XLin;
yQuad = bQuad' * XQuad;



%fit figure
figure;
plot(x, y, 'b o', 'LineWidth', 2);
hold on;
plot(x, yLin,  'g-', 'LineWidth', 2);
plot(x, yQuad, 'r-', 'LineWidth', 2);
xlabel('Data point number'), ylabel('Data point value'), title('Raw noisy data plot+fitted line', 'FontWeight','bold')
legend('raw data' , 'linear fit', 'quadratic fit')
grid on ;