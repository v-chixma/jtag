function sout = ddeblank(s)
% DDEBLANK    Double deblank. Strip both leading and trailing blanks.
%
%    DDEBLANK(S) removes leading and trailing blanks and null characters from
%    the string S.  A null character is one that has an absolute value of 0.


% CVS INFO %
%%%%%%%%%%%%
% $Id: ddeblank.m,v 1.1 2003-07-23 14:54:43 scottl Exp $
% 
% REVISION HISTORY:
% $Log: ddeblank.m,v $
% Revision 1.1  2003-07-23 14:54:43  scottl
% Initial revision.
%


% LOCAL VARS %
%%%%%%%%%%%%%%

error(nargchk(1, 1, nargin));
if ~ischar(s)
  error('Input must be a string (char array).');
end

if isempty(s)
    sout = s;
    return;
end

[r, c] = find( s ~= ' ' & s ~= 0 );
if size(s, 1) == 1
    sout = s(min(c):max(c));
else
    sout = s(:,min(c):max(c));
end
