function [yy] = knn_smooth (x,y,xx,K)
% KNN Smoothing
% FORMAT [yy] = knn_smooth (x,y,xx,K)
%
% x     independent variable
% y     dependendent variable
% xx    vector over which to compute smoothed dependent variable
% K     K neighbours
%
% yy    smoothed dependent variable

for i=1:length(xx),
    % Find K nearest neighbours
    d=(x-xx(i)).^2;
    [tmp,ind]=sort(d,'ascend');
    
    % Weight exponentially according to distance and renormalise
    w=exp(-tmp(1:K))+eps;
    w=w/sum(w);
    
    % Compute smoothed value
    yy(i)=w'*y(ind(1:K));
    
%     if isnan(yy(i))
%         keyboard
%     end
end
yy=yy(:);

