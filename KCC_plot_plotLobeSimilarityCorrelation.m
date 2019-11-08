function KCC_plot_plotLobeSimilarityCorrelation(h,lobesCorr,similarity)
% This function of the KCC (Kenyon Cell Correlator) toolbox calculates the
% xcorr for all buttons of all cells 
% 
% GETS:
%         h     = 2 figure handles (vector)    
%     lobesCorr = mxmx4x2 matrix with the cross correlation coefficients,
%                 normalised to the autocorrelation for the y lobes. We 
%                 correlate all boutons of one lobe with them selfes and
%                 other lobes. The coffecient are stored in this variable
%                 as follows:
%                 m is the number of lobes
%                 3rd dimension 1 of the four odors
%                 4th dimension first pre than post training condition
%    similarity = mxmx4x2 an identical matrix lobes corr only this time all
%                 coefficients are multiplied with two scaling factors: 1)
%                 a 1-(Michelson contrast) of the median response amplitude 
%                 and the sum of both median response amplitude (normalised
%                 to the maximum of all odor and training conditions)
%
% RETURNS: two figures with figure handles h
%
% SYNTAX: KCC_plot_plotLobeSimilarityCorrelation(h,lobesCorr,similarity);
%
% Author: B. Geurten 1.3.2017
%
% see also xcorr

figure(h(1)),clf
figure(h(2)),clf

titleStr={'MCH' ,'3Oct','1Oct','Oil'};
counter = 1;
for prePostI =1:2
    for odorI=1:4,
        
        figure(h(1))
        subaxis(2,4,counter,'SpacingVert',0.05,'SpacingHoriz',0.05)
        pcolor(pcolor_patchUpMatrix(lobesCorr(:,:,odorI,prePostI)))
        
        axis image
        set(gca,'XTick',1.5:4.5)
        set(gca,'XTickLabel',2:5)
        set(gca,'YTick',1.5:4.5)
        set(gca,'YTickLabel',fliplr(2:5))
        caxis([-1 1])
        colormap(redblueDiff('middle'))
        colorbar
        if prePostI == 1,
            
            title([ 'pre ' titleStr{odorI}])
        else
            
            title([ 'post ' titleStr{odorI}])
        end
        figure(h(2))
        subaxis(2,4,counter,'SpacingVert',0.05,'SpacingHoriz',0.05)
        pcolor(pcolor_patchUpMatrix(similarity(:,:,odorI,prePostI)))
        
        axis image
        set(gca,'XTick',1.5:4.5)
        set(gca,'XTickLabel',2:5)
        set(gca,'YTick',1.5:4.5)
        set(gca,'YTickLabel',fliplr(2:5))
        caxis([0 1])
        colormap(hot)
        colorbar
        if prePostI == 1,
            
            title([ 'pre ' titleStr{odorI}])
        else
            
            title([ 'post ' titleStr{odorI}])
        end
        counter = counter+1;
    end
end