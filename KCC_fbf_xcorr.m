function corrMat = KCC_fbf_xcorr(dataF,corrWin,fps,maxPhaseShift)
% This function of the KCC (Kenyon Cell Correlator) toolbox calculates the
% xcorr for all buttons of all cells 
% 
% GETS:
%         dataF = filtered version of with delta f by values 
%                 mxnx4x2 matrix, where:
%                 m is the number of samples
%                 n is the number of buttons in the gamma lobes
%                 3rd dimension 1 of the four odors
%                 4th dimension first pre than post training condition     
%       corrWin = start and end of the response window that is correlated
%                 in seconds (default [4 13])
%           fps = sample frequency of the calcium imaging (default 4 )   
% maxPhaseShift = xcorr phase shift (default 5 frames)
%
% RETURNS:
%       corrMat = mxmx4x2 matrix with the cross correlation coefficients,
%                 normalised to the autocorrelation, where 
%                 m is the number of buttons
%                 3rd dimension 1 of the four odors
%                 4th dimension first pre than post training condition
%
% SYNTAX: corrMat = KCC_fbf_xcorr(dataF,corrWin,fps,maxPhaseShift);
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

if exist('maxPhaseShift','var'),
    if isempty(maxPhaseShift),
        maxPhaseShift=5;
    end
else
    maxPhaseShift =5;
end

if exist('fps','var'),
    if isempty(fps),
        fps=4;
    end
else
    fps =4;
end

corrWin = corrWin.*fps;
buttonNo = size(dataF,2);
if size(dataF,4) == 1,
    corrMat = NaN(buttonNo,buttonNo,4,1);
else,
    corrMat = NaN(buttonNo,buttonNo,4,2);
end
for preI=1:size(dataF,4),
    for slideI = 1:4,
        for buttonI1 = 1:buttonNo-1,
            for buttonI2 = buttonI1+1:buttonNo,
                [c,~] = xcorr(dataF(corrWin(1):corrWin(2),buttonI1,slideI,preI),...
                    dataF(corrWin(1):corrWin(2),buttonI2,slideI,preI),...
                    maxPhaseShift,'coeff');
                [~,idx] = max(abs(c));
                corrMat(buttonI1,buttonI2,slideI,preI) =c(idx);
                corrMat(buttonI2,buttonI1,slideI,preI) =c(idx);
            end
        end
    end
end