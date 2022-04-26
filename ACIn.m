
% This script calculates the aerosol-cloud interaction index...
% to examine the response of cloud droplet number concentration (CDNC) to aerosol
% number concentration (Na). The equation is as follows:

% ACIn= d ln⁡ (CDNC)/ 3*(d ln⁡ (N_a));

% Contact: Karam Mansour (k.mansour@isac.cnr.it)

function [ACI_l, ACI_m, ACI_h,r_l,r_m,r_h,p_l,p_m,p_h] = ACIn(Na,CDNC,LWC)

% Input
% Na:   aerosol number concentration
% CDNC: cloud droplet number concentration 
% LWC:  cloud liquid water content


% Output
% for all output: l stands for Low LWC, m stands for Medium LWC, and h stands for High LWC  
% ACI: the index
% r: corrCoeff
% p: p-value

% make sure there is no missing data in the input

% ACIn using LWC
% Calculate percentiles
x1 = quantile(LWC,1/3); % third
x2 = quantile(LWC,2/3); % two-third

l = find(LWC <= x1);                % l: stands for low LWC
m = find(LWC > x1 & LWC <= x2);     % m: stands for low LWC
h = find(LWC > x2);                 % h: stands for low LWC
clear x1 x2

% slope in log-log space 
pfit_l = polyfit(log(Na(l)), log(CDNC(l)), 1);
pfit_m = polyfit(log(Na(m)), log(CDNC(m)), 1);
pfit_h = polyfit(log(Na(h)), log(CDNC(h)), 1);

% ACI indices
ACI_l = pfit_l(1)/3;     clear pfit_a
ACI_m = pfit_m(1)/3;     clear pfit_b
ACI_h = pfit_h(1)/3;     clear pfit_c

% correlation coeff
[r_l,p_l]= corrcoef(log(Na(l)), log(CDNC(l)));
[r_m,p_m]= corrcoef(log(Na(m)), log(CDNC(m)));
[r_h,p_h]= corrcoef(log(Na(h)), log(CDNC(h)));

end
