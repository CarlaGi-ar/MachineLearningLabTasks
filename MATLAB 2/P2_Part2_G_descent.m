%linear regressions with Gradient Descent
%we dont know m and c so we start from a guess
theta0=0;
theta1=0;
%create alpha start and number of collumns
alpha=0.01;
numIters=1000;

%create teh array to store the cost of each iteration
cost= zeros(1, numIters);
theta0_init = theta0;
theta1_init = theta1;
%loop over iterations 
% 1. predict y with the current guess
for k = 1:numIters
    yHat = theta0 + theta1 * x;  
    % 2. how wrong is each point?
    err  = yHat - y;    
    % 3. one number for "how wrong overall"
    cost(k) = (1/(2*N)) * sum(err.^2);    
% 4. which way to move theta0
    grad0 = (1/N) * sum(err);             
    grad1 = (1/N) * sum(err .* x);        
%    which way to move theta1
% 5. take a small step downhill
    theta0 = theta0 - alpha * grad0;      
    theta1 = theta1 - alpha * grad1;
end

disp([theta0 theta1])

figure;

% ---- figure data + lines ----
figure
plot(x, y, 'b-o'); hold on;
plot(x, theta0_init + theta1_init * x, 'g-x');      % initial guess
plot(x, theta0 + theta1 * x, 'r-x', 'LineWidth', 2); % final line
legend('target data', 'Initial guess', 'final version');
xlabel('x'); ylabel('y');
title('Scalar Gradient Fitted curve');
grid on;

% ---- figure  error curve ----
figure
plot(1:numIters, cost, 'b-o');
xlabel('Iteration'); ylabel('Data error value');
title(['Final error = ' num2str(cost(end))]);
grid on;