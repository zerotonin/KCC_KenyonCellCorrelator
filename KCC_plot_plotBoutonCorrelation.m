function KCC_plot_plotBoutonCorrelation(h,corrMat,ylobesIDX)
% This function of the KCC (Kenyon Cell Correlator) toolbox calculates the
% xcorr for all buttons of all cells 
% 
% GETS:
%         h     = figure handle    
%       corrMat = mxmx4x2 matrix with the cross correlation coefficients,
%                 normalised to the autocorrelation, where 
%                 m is the number of buttons
%                 3rd dimension 1 of the four odors
%     ylobesIDX = n long vector with number s between 2 and 4, indicating in
%                 which gamma lobes the button was.
%
% RETURNS: a figure with figure handle h
%
% SYNTAX: corrMat = KCC_plot_plotBoutonCorrelation(h,corrMat);
%
% Author: B. Geurten 1.3.2017
%
% see also xcorr

boutonNo = size(corrMat,1);
titleStr={'MCH' ,'3Oct','1Oct','Oil'};
figure(h),clf
counter = 1;
for prePostI =1:2,
    for odorI = 1:4,
        subaxis(2,4,counter,'SpacingVert',0.005,'SpacingHoriz',0.005)
        test = pcolor_patchUpMatrix(corrMat(:,:,odorI,prePostI));
        pcolor(test)
        colormap(redblueDiff('middle'))
        caxis([-1 1])
        colorbar
        axis image
        if prePostI == 1,
            
            title([ 'pre ' titleStr{odorI}])
        else
            
            title([ 'post ' titleStr{odorI}])
        end
        set(gca,'XTick',1.5:boutonNo+0.5)
        set(gca,'YTick',1.5:boutonNo+0.5)
        set(gca,'XTickLabel',ylobesIDX)
        set(gca,'YTickLabel',fliplr(ylobesIDX))
        counter = counter+1;
        axis image
    end
end