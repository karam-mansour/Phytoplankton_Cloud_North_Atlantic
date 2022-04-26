
% The code is used to create and save a 2D-Histogram (log-log space) between CDNC and Albedo...
% as well as calculation of CDNC-Albedo sensitivity

% Contact: Karam Mansour (k.mansour@isac.cnr.it)

function [sensitivity] = CDNC_Albedo_sensitivity(CDNC,Albedo)

% Input
% CDNC:   cloud droplet number concentration (1 cloumn)
% Albedo: cloud Albedo                       (1 cloumn)

% Output
% sensitivity of CDNC to Albedo
% 2D-Histogram in (log-log space)

% make sure there is no missing data in the input, and the sizes are equal

% 2D-Histogram
% To create evenly spaced  bins in log scale:
[~,edges_cdnc] = histcounts(log10(CDNC));
[~,edges_Albedo]  = histcounts(log10(Albedo));

Fig=figure();
h = histogram2(CDNC,Albedo,'DisplayStyle','tile','Normalization','probability');
set(gca,'YScale','log')
set(gca,'XScale','log')
h.XBinEdges=10.^edges_cdnc;     clear edges_cdnc
h.YBinEdges=10.^edges_Albedo;      clear edges_Albedo
h.EdgeColor='none';
xlabel('CDNC (cm^{-3})')
ylabel('Albedo')
colormap(flip(copper))
grid off

% Fit All data
pfit = polyfit(log10(CDNC), log10(Albedo), 1);
pval = polyval(pfit, log10(CDNC));

hold on
loglog(CDNC,10.^(pval),'--b','LineWidth',2);	clear pval
set(gca,'FontSize',10,'FontWeight','bold')
saveas(Fig,'2DHistoram_CDNC_Albedo.tif')
close all
clear h Fig

sensitivity = pfit(1);

end
