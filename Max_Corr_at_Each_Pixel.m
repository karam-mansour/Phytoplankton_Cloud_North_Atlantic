
% This script evidences the maximum value of correlation coefficients
% between aerosol/cloud and chlorophyll-a (output from: Spatiotemporal_Corr_with_time_lag.m)
% at each pixel of the studied domain.

% Contact: Karam Mansour (k.mansour@isac.cnr.it)

function MaxR= Max_Corr_at_Each_Pixel(R,P)

% Input
% R: Correlation coefficients, returned as a matrix (x: lon, y: lat, z: time-lag)
% P: P-values, returned as a matrix. P is symmetric and is the same size as R. 

% Output
% MaxR: max correlation 

% Consider only significant correlation at p<0.05
R(P > 0.05)=nan;    clear P	% exclude non-significant


% Select from 0 to 15 Days time-lag
Corr_Matrix = R(:,:,1:16);  clear R

% Find Max R at each pixel
MaxR=nan (size(Corr_Matrix,1),size(Corr_Matrix,2));
for i= 1:size(Corr_Matrix,1)
    for j= 1:size(Corr_Matrix,2)

        X=squeeze (Corr_Matrix(i,j,:));
        MaxR(i,j)=max(X);
                
        clear X
    end
end
clear i j Corr_Matrix

end
