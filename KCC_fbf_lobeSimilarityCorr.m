function [similarity,lobesCorr] = KCC_fbf_lobeSimilarityCorr(corrMat,ylobesIDX,amps,ampsN)
% This function of the KCC (Kenyon Cell Correlator) toolbox. Loads the
% delta f by f data. As produce for the 2017 Bilz Data set. The 4 different
% odors are below each other. The precondition is on page 1 the post
% condition on page 2.
% 
% GETS:
%       corrMat = mxmx4x2 matrix with the cross correlation coefficients,
%                 normalised to the autocorrelation, where 
%                 m is the number of buttons
%                 3rd dimension 1 of the four odors
%                 4th dimension first pre than post training condition
%     ylobesIDX = n long vector with number s between 2 and 4, indicating 
%                 in which gamma lobes the button was.   
%          amps = maximum amplitude of the mean delta f by f signal inside the
%                 correlation window in percent. 4x4x2 matrix where rows are the
%                 odors and column code for gamma-lobes and 3rd dimension for 
%                 pre and post
%         ampsN = the same as amps only normalised to the maximum of pre and
%                 post
% RETURNS:
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
%                 and the mean of both median response amplitude (normalised
%                 to the maximum of all odor and training conditions)
%
% SYNTAX: [similarity,lobesCorr] = KCC_fbf_lobeSimilarityCorr(corrMat,ylobesIDX,amps,ampsN);
%
% Author: B. Geurten 2.3.2017
%
% see also mean, max
amps = abs(amps);
ampsN = abs(ampsN);
if size(corrMat,4) == 1,
    lobesCorr = NaN(4,4,4);
    similarity = NaN(4,4,4);
else,
    lobesCorr = NaN(4,4,4,2);
    similarity = NaN(4,4,4,2);
end

for prePostI =1:size(corrMat,4),
    for odorI=1:4,
        temp = corrMat(:,:,odorI,prePostI);
        for i = 2:5,
            for j = i:5,
                combi = temp(ylobesIDX ==i,ylobesIDX ==j);
                combi = unique(reshape(combi,1,numel(combi)));
        
                lobesCorr(i-1,j-1,odorI,prePostI) = nanmedian(combi);
                lobesCorr(j-1,i-1,odorI,prePostI) = nanmedian(combi);
            end
        end
        ampFactor  = 1+abs( bsxfun(@rdivide,bsxfun(@minus,amps(odorI,:,prePostI),amps(odorI,:,prePostI)'),...
            bsxfun(@plus,amps(odorI,:,prePostI),amps(odorI,:,prePostI)'))).*-1;
        %divided by two for mean
        ampFactor  = bsxfun(@times,bsxfun(@plus,ampsN(odorI,:,prePostI),ampsN(odorI,:,prePostI)')./2,ampFactor);
        similarity(:,:,odorI,prePostI) = bsxfun(@times,abs(lobesCorr(:,:,odorI,prePostI)),ampFactor);
    end
end

% this is just to set diagonals to zero or 1
% for prePostI =1:size(corrMat,4),
%     for i =1:4,
%         for j =1:4
%         similarity(i,i,j,prePostI) = 0;
%         end
%     end
% end
% %similarity = abs(similarity./max(reshape(similarity,numel(similarity),1)))
% 
% for prePostI =1:size(corrMat,4),
%     for i =1:4,
%         for j =1:4
%         similarity(i,i,j,prePostI) = 1;
%         end
%     end
% end
