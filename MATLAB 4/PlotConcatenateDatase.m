%function to plot the concatenate datasets
function PlotConcatenateDatase(TrainData)
figure;
plot(TrainData(:,1), TrainData(:,2),'b.');
legend('Dataset');
title('Merged Dataset');
xlabel('x-value');
ylabel('y-value');
grid on;

end