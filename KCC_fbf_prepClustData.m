function [data,dataZS] = KCC_fbf_prepClustData(dataF,ylobesIDX,corrWin,fps)
% This function of the KCC (Kenyon Cell Correlator) toolbox. Loads the
% delta f by f data. As produce for the 2017 Bilz Data set. The 4 different
% odors are below each other. The precondition is on page 1 the post
% condition on page 2.
% 
% GETS:
%         dataF = filtered version of with delta f by values 
%                 mxnx4x2 matrix, where:
%                 m is the number of samples
%                 n is the number of buttons in the gamma lobes
%                 3rd dimension 1 of the four odors
%                 4th dimension first pre than post training condition  
%     ylobesIDX = n long vector with number s between 2 and 4, indicating 
%                 in which gamma lobes the button was.   
%       corrWin = start and end of the response window that is correlated
%                 in seconds (default [4 13])
%           fps = sample frequency of the calcium imaging (default 4 ) 
%
% RETURNS:
%     dataFM = mx4x4x2 matrix with mean delta f by values, where:
%              m is the number of samples
%              2nd dimension  4 different y lobes
%              3rd dimension 1 of the four odors
%              4th dimension first pre than post training condition
%       amps = maximum amplitude of the mean delta f by f signal inside the
%              correlation window in percent. 4x4x2 matrix where rows are the
%              odors and column code for gamma-lobes and 3rd dimension for 
%              pre and post
%      ampsN = the same as amps only normalised to the maximum of pre and
%              post
%
% SYNTAX: [dataFM,amps,ampsN] = KCC_fbf_meanAmps(dataF,corrWin,fps);
%
% Author: B. Geurten 1.3.2017
%
% see also mean, max

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

%get peak amplitude and time per button
[amps, ampsI] = max(dataF(corrWin(1)*fps:corrWin(2)*fps,:,:,:),[],1);
ampsI = ampsI*fps+corrWin(1)*fps;

%reshape so that mx4x2 results where m is the number of the button
amps = reshape(amps, [size(amps,2),4,2]);
ampsI = reshape(ampsI, [size(ampsI,2),4,2]);

%now rearrange into clusterable data 
data = NaN(size(amps,1),2,2,4);
for i =1:size(amps,2)
data(:,:,:,i) = [amps(:,i,:) ampsI(:,i,:)];
end
dataZS = zscore(data);