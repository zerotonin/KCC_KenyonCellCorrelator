function [data,ylobesIDX] = KCC_fIO_loadXLSX(fPos,samples,gap)
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

pre = xlsread(fPos,1); 
post = xlsread(fPos,2);

[~,ylobes] = xlsread(fPos,1,'A1:GZ1');
ylobesIDX = cellfun(@(x) str2double(x(2:end)),ylobes);


dataPre = cat(3,pre(1:samples,:),pre(gap+samples:gap+samples*2-1,:));
dataPre = cat(3,dataPre,pre(gap*2+samples*2-1:gap*2+samples*3-2,:));
dataPre = cat(3,dataPre,pre(gap*3+samples*3-2:end,:));

try
    dataPost = cat(3,post(1:samples,:),post(gap+samples:gap+samples*2-1,:));
    dataPost = cat(3,dataPost,post(gap*2+samples*2-1:gap*2+samples*3-2,:));
    dataPost = cat(3,dataPost,post(gap*3+samples*3-2:end,:));
    
    data = cat(4,dataPre,dataPost);
catch
    data = dataPre;
end