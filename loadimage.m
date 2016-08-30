function [f,fn,map]=LoadImage(prompt,pth);
%---------------------------------
%   [f,fn,map]=LoadImage(prompt,path) opens an image file and returns bitmap image matrix f and g,
%       Default of prompt is 'Read a JPEG image.'.
%       Default of pth is 'i\'.
%
%   CoptRight(c): S.Wang, Sept 2002
%---------------------------------
if ~nargin
    prompt='Read a JPEG image.';pth='i\';
elseif nargin==1
    pth='i\';
end

[t,p]=uigetfile([pth,'*.*'],prompt);
fn=[p t];

[f,map]=imread(fn);
%g=double(f);
