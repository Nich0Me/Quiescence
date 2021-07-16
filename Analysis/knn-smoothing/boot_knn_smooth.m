function [my,y05,y95] = boot_knn_smooth(x,y,xx,K,bootsamps)
% Bootstrapped KNN smoothing
% FORMAT [my,y05,y95] = boot_knn_smooth(x,y,xx,K,bootsamps)
%
% my     (mean) smoothed y time series
% y05    5th percentile time series
% y95    95th percentile time series

N=length(x);
ind=ceil(rand(N,bootsamps)*N); % Sampling with replacement
for b=1:bootsamps,
    bx=x(ind(:,b));
    by=y(ind(:,b));
    yy(:,b)=knn_smooth(bx,by,xx,K);
end

my=mean(yy,2);
for i=1:length(xx),
    [tmp,ind]=sort(yy(i,:),'ascend');
    y05(i)=tmp(round(0.05*bootsamps));
    y95(i)=tmp(round(0.95*bootsamps));
end
