function [data,ylobesIDX] = KCC_buttonAmpThresh(data,ylobesIDX)
% This function of the KCC (Kenyon Cell Correlator) toolbox. Loads the
% delta f by f data. As produce for the 2017 Bilz Data set. The 4 different
% odors are below each other. The precondition is on page 1 the post
% condition on page 2.
% 
% GETS:
%       fPos = file position
%    samples = no of samples during calcium imaging (80)
%       gaps = empty rows between odors (3)
%
% RETURNS:
%       data = mxnx4x2 matrix with delta f by values, where:
%              m is the number of samples
%              n is the number of buttons in the gamma lobes
%              3rd dimension 1 of the four odors
%              4th dimension first pre than post training condition
%  ylobesIDX = n long vector with number s between 2 and 4, indicating in
%              which gamma lobes the button was.
%
% SYNTAX: [data,ylobesIDX] = KCC_fIO_loadXLSX(fPos,samples,gap);
%
% Author: B. Geurten 1.3.2017
%
% see also xlsread, cat


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



dataMean = nanmean(data,4);
dataMean = nanmean(dataMean,3);
dataMean = nanmean(dataMean,1);

dataStd = nanstd(data,[],4);
dataStd = nanstd(dataStd,[],3);
dataStd = nanstd(dataStd,[],1).*5;

threshold = bsxfun(@plus,dataMean,dataStd);

maxAmp = nanmax(data,[],4);
maxAmp = nanmax(maxAmp,[],3);
maxAmp = nanmax(maxAmp(corrWin(1)*fps:corrWin(2)*fps(),:),[],1);

IDX = bsxfun(@gt,maxAmp,threshold);

ylobesIDX = ylobesIDX(IDX);
data = data(:,IDX,:,:);