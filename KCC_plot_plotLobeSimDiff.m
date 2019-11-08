function KCC_plot_plotLobeSimDiff(h,simDiff)
% This function of the KCC (Kenyon Cell Correlator) toolbox calculates the
% xcorr for all buttons of all cells 
% 
% GETS:
%         h     = figure handle 
%       simDiff = mxmx4x2 matrix with the differences in similarity
%                 introduced by the differential learning treament, data is
%                 saved as follows:
%                 m is the number of lobes
%                 3rd dimension 1 of the four odors
%                 4th dimension first pre than post training condition
%
% RETURNS: two figures with figure handles h
%
% SYNTAX: KCC_plot_plotLobeSimilarityCorrelation(h,lobesCorr,similarity);
%
% Author: B. Geurten 1.3.2017
%
% see also xcorr

figure(h(1)),clf

titleStr={'MCH' ,'3Oct','1Oct','Oil'};
counter = 1;
for odorI=1:4,
    
    figure(h)
    subaxis(1,4,counter,'SpacingVert',0.05,'SpacingHoriz',0.05)
    pcolor(pcolor_patchUpMatrix(simDiff(:,:,odorI)))
    
    axis image
    set(gca,'XTick',1.5:4.5)
    set(gca,'XTickLabel',2:5)
    set(gca,'YTick',1.5:4.5)
    set(gca,'YTickLabel',fliplr(2:5))
    caxis([-0.5 .5])
    colormap(redblueDiff('middle'))
    colorbar
    
    title([ 'difference ' titleStr{odorI}])
    
    counter = counter+1;
end
