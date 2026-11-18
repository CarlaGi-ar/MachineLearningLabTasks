%task two Gaussian Mixture Model (GMM)
function[idxGMM, gm]=runGMM(X, K)

%fitting GMM with real K components
gm= fitgmdist(X, K, 'Options', statset('MaxIter', 1000));

%assigning  each point to a GMM component
idxGMM= cluster(gm, X);

end