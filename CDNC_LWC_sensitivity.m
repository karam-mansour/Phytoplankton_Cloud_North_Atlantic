
% The code is used to create and save a 2D-Histogram (log-log space) between CDNC and LWC...
% as well as calculation of CDNC-LWC sensitivity

% Contact: Karam Mansour (k.mansour@isac.cnr.it)

function [sensitivity] = CDNC_LWC_sensitivity(CDNC,LWC)

% Input
% CDNC: cloud droplet number concentration (1 cloumn)
% LWC:  cloud liquid water content         (1 cloumn)

% Output
% sensitivity of CDNC to LWC
% 2D-Histogram in (log-log space)

% make sure there is no missing data in the input, and the sizes are equal

% 2D-Histogram
% To create evenly spaced  bins in log scale:
[~,edges_cdnc] = histcounts(log10(CDNC));
[~,edges_lwc]  = histcounts(log10(LWC));

Fig=figure();
h = histogram2(CDNC,LWC,'DisplayStyle','tile','Normalization','probability');
set(gca,'YScale','log')
set(gca,'XScale','log')
h.XBinEdges=10.^edges_cdnc;     clear edges_cdnc
h.YBinEdges=10.^edges_lwc;      clear edges_lwc
h.EdgeColor='none';
xlabel('CDNC (cm^{-3})')
ylabel('LWC (g m^{-3})')
colormap(flip(copper))
grid off

% Fit All data
pfit = polyfit(log10(CDNC), log10(LWC), 1);
pval = polyval(pfit, log10(CDNC));

hold on
loglog(CDNC,10.^(pval),'--b','LineWidth',2);	clear pval
set(gca,'FontSize',10,'FontWeight','bold')
saveas(Fig,'2DHistoram_CDNC_LWC.tif')
close all
clear h Fig

sensitivity = pfit(1);

end
