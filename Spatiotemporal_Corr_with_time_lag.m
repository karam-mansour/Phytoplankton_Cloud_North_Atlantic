% This Matlab script calculates the spatial correlation between 
% chlorophyll-a concentration (can be applied on any other parameters) 
% over an oceanic domain (e.g., North Atlantic) and aerosol/cloud parameters 
% at a sampling station (e.g., Mace Head, Ireland)
% The correlations can be applied simultaneously and by applying time-lags.

% Contact: Karam Mansour (k.mansour@isac.cnr.it)

function [R, P]= Spatiotemporal_Corr_with_time_lag(chl,lat,lon,tchl,var,tvar)

% Input
% chl: chlorophyll-a concentration as a 3D matrix where x longitude, y latitude and z timing
% lat: latitude of chlorophyll-a data
% lon: longitude of chlorophyll-a data
% tchl: timing of chl (daily) as datetime
% var: aerosol or cloud parameter at the sampling station
% tvar: timing of aersol/cloud (daily) as datetime

% Output
% R: Correlation coefficients, returned as a matrix (x: lon, y: lat, z: time-lag)
% P: P-values, returned as a matrix. P is symmetric and is the same size as R. 

% Find the index corresponding to the days of aeorsol/cloud observations 
idx=nan(size(tvar));
for i=1:length(tvar)
    idx(i)=find(tchl==tvar(i));
end
clear i 

% Apply the correlation with tim-lag from 0 to 25 days
R=nan(length(lon),length(lat),26);
P=nan(length(lon),length(lat),26);
for k=0:25         % Lag from 0 to 25 days

    chl_=chl(:,:,idx);
    for i=1:size(chl_,1)               % find the corr. coeff. between chl and var at each pixel
        for j=1:size(chl_,2)
            X=squeeze(chl_(i,j,:));
            [r, p] = corrcoef(X,var,'Rows','complete'); %  use complete to exclude any rows that contain NaN.
            R(i,j,k+1) = r(1,2);     clear r     % Correlation matrix
            P(i,j,k+1) = p(1,2);     clear p     % Significance level
            clear X
        end
    end
    idx=idx-1; clear chl_
end
clear i j k idx chl

end
