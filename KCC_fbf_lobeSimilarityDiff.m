function simDiff = KCC_fbf_lobeSimilarityDiff(similarity)
% This function of the KCC (Kenyon Cell Correlator) toolbox. Loads the
% delta f by f data. As produce for the 2017 Bilz Data set. The 4 different
% odors are below each other. The precondition is on page 1 the post
% condition on page 2.
% 
% GETS:
%    similarity = mxmx4x2 an identical matrix lobes corr only this time all
%                 coefficients are multiplied with two scaling factors: 1)
%                 a 1-(Michelson contrast) of the median response amplitude 
%                 and the mean of both median response amplitude (normalised
%                 to the maximum of all odor and training conditions)
% RETURNS:
%       simDiff = mxmx4x2 matrix with the differences in similarity
%                 introduced by the differential learning treament, data is
%                 saved as follows:
%                 m is the number of lobes
%                 3rd dimension 1 of the four odors
%                 4th dimension first pre than post training condition
%
% SYNTAX: simDiff = KCC_fbf_lobeSimilarityDiff(similarity);
%
% Author: B. Geurten 2.3.2017
%
% see also mean, max

simDiff = bsxfun(@minus,similarity(:,:,:,2),similarity(:,:,:,1));