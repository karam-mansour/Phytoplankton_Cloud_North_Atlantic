
% This code calculates the Time-lag which maximizes the
% correlation coefficients between aerosol/cloud and chlorophyll-a (output from: Spatiotemporal_Corr_with_time_lag.m)

% Contact: Karam Mansour (k.mansour@isac.cnr.it)

function TimeLag_MaxR= Timelag_maximizes_Correlation(R,P)

% Input
% R: Correlation coefficients, returned as a matrix (x: lon, y: lat, z: time-lag)
% P: P-values, returned as a matrix. P is symmetric and is the same size as R. 

% Output
% Time-Lag at which the max correlation happens

% Consider only significant correlation at p<0.05
R(P > 0.05)=nan;    clear P	% exclude non-significant

% Select from 0 to 15 Days time-lag
Corr_Matrix = R(:,:,1:16);  clear R

TimeLag_MaxR=nan (size(Corr_Matrix,1),size(Corr_Matrix,2));
for i= 1:size(Corr_Matrix,1)
    for j= 1:size(Corr_Matrix,2)

        X=squeeze (Corr_Matrix(i,j,:));
        MAX=max(X);

        id=find(X==MAX);
        
        if isempty(id)     % non-empty pixls (land)
            TimeLag_MaxR(i,j)=nan;
        else
            TimeLag_MaxR(i,j)=(id-1);
        end
        
        clear X id MAX
    end
end
clear i j Corr_Matrix

end
