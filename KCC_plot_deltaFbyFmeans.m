function KCC_plot_deltaFbyFmeans(h,dataF,dataFM,ylobesIDX,corrWin,fps)
% This function of the KCC (Kenyon Cell Correlator) toolbox calculates the
% xcorr for all buttons of all cells
%
% GETS:
%         h     = 2 value vector with figure handles
%         dataF = filtered version of with delta f by values
%                 mxnx4x2 matrix, where:
%                 m is the number of samples
%                 n is the number of buttons in the gamma lobes
%                 3rd dimension 1 of the four odors
%                 4th dimension first pre than post training condition
%        dataFM = mx4x4x2 matrix with mean delta f by values, where:
%                 m is the number of samples
%                 2nd dimension  4 different y lobes
%                 3rd dimension 1 of the four odors
%                 4th dimension first pre than post training condition
%     ylobesIDX = n long vector with number s between 2 and 4, indicating in
%                 which gamma lobes the button was.
%       corrWin = start and end of the response window that is correlated
%                 in seconds (default [4 13])
%           fps = sample frequency of the calcium imaging (default 4 )
%
% RETURNS: two figure with figure handle h(1) and h(2)
%
% SYNTAX: KCC_plot_deltaFbyFmeans(h,dataF,dataFM,ylobesIDX,corrWin,fps);
%
% Author: B. Geurten 1.3.2017
%
% see also xcorr


if exist('corrWin','var'),
    if isempty(corrWin),
        corrWin=[4 13];
    end
else
    corrWin =[4 13];
end
if exist('fps','var'),
    if isempty(fps),
        fps=4;
    end
else
    fps =4;
end

sampleNo = size(dataFM,1);
xAx =linspace(0,sampleNo/fps,sampleNo);
titleStr={'MCH' ,'3Oct','1Oct','Oil'};
maxAmp = max(max(max(max(dataF))));

figure(h(1)),clf
counter = 1;
for prePostI =1:2
    for odorI = 1:4,
        
        subaxis(2,4,counter,'SpacingVert',0.05,'SpacingHoriz',0.01);
        lh=NaN(5,1);
        for yI =2:5,
            hold on
            if sum(ylobesIDX==yI) ~=0
            plot(xAx,dataF(:,ylobesIDX==yI,odorI,prePostI),'Color',paletteKeiIto(yI-1));
            end
        end
        hold on
        for yI =1:4,
            hold on
            lh(yI)=plot(xAx,dataFM(:,yI,odorI,prePostI),'Color',paletteKeiIto(yI),'LineWidth',3);
        end
        lh(5)= plot(corrWin,zeros(2,1),'--','Color',paletteKeiIto(5),'LineWidth',3);
        if prePostI == 1,
            
            title([ 'pre ' titleStr{odorI}])
        else
            
            title([ 'post ' titleStr{odorI}])
        end
        
        hold off
        axis([0 xAx(end) 0 maxAmp])
        
        legend (lh,{'y-lobe 2','y-lobe 3','y-lobe 4','y-lobe 5','correlation window'}')
        counter = counter +1;
    end
end
figure(h(2)),clf
counter = 1;
for prePostI =1:2
    for odorI = 1:4,
        
        subaxis(2,4,counter,'SpacingVert',0.05,'SpacingHoriz',0.01);
        
        
        for yI =1:4,
            hold on
            lh(yI)=plot(xAx,dataFM(:,yI,odorI,prePostI),'Color',paletteKeiIto(yI),'LineWidth',3);
        end
        lh(5)= plot(corrWin,zeros(2,1),'--','Color',paletteKeiIto(5),'LineWidth',3);
        if prePostI == 1,
            
            title([ 'pre ' titleStr{odorI}])
        else
            
            title([ 'post ' titleStr{odorI}])
        end
        hold off
        axis([0 xAx(end) 0 maxAmp])
        counter = counter +1;
        
        legend (lh,{'y-lobe 2','y-lobe 3','y-lobe 4','y-lobe 5','correlation window'}')
    end
end