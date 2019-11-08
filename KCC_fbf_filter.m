function dataF = KCC_fbf_filter(data,deg,cut)
% This function of the KCC (Kenyon Cell Correlator) toolbox filters the raw
% data so that we can easier find the peak response.
% 
% GETS:
%       data = mxnx4x2 matrix with delta f by values, where:
%              m is the number of samples
%              n is the number of buttons in the gamma lobes
%              3rd dimension 1 of the four odors
%              4th dimension first pre than post training condition
%         deg = degree of the butterworth (default: 2)
%         cut = cut off for the butterworthfilter (default 0.75)
%
% RETURNS:
%      dataF = filtered version of mxnx4x2 matrix, where:
%              m is the number of samples
%              n is the number of buttons in the gamma lobes
%              3rd dimension 1 of the four odors
%              4th dimension first pre than post training condition
%
% SYNTAX: dataF = KCC_fbf_filter(data,deg,cut);
%
% Author: B. Geurten 1.3.2017
%
% see also butter, filtfilt

if exist('deg','var'),
    if isempty(deg),
        deg=2;
    end
else
    deg =2;
end
if exist('cut','var'),
    if isempty(cut),
        cut=0.75;
    end
else
    cut =0.75;
end
[B,A] = butter(deg,cut);
dataF = filtfilt(B,A,data) ;