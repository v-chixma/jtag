function s = parse_jlog(file, st)
% PARSE_JLOG    Reads the contents of the jlog file passed, adding it to the 
%               parse_jtag resultant structure array passed.
%
%   S = PARSE_JLOG(FILE, ST) Attempts to validate and open FILE passed, 
%   reading its header and selection information into fields of structure S 
%   (using parse_jtag result structure ST as a basis -- it must have a 'rects' 
%   field) as
%   follows:
%
%     s.jlog_file  -> the full path and name to the .jtag file used to create s
%     s.img_file   -> the full path and name to the associated image file
%     s.rects      -> n x 4 matrix listing the 4 position values L,T,R,B of
%                     each of the n selection rectangles made for this image
%     s.sel_time   -> n x 1 matrix listing the total time in seconds it has
%                     taken create the associated selection rectangle in
%                     s.rects
%     s.class_time -> n x 1 matrix listing the total time in seconds it has
%                     taken to drag the associated selection rectangle in
%                     s.rects to its class bucket
%     s.attempts   -> n x 1 matrix listing the total number of classification
%                     attempts that have been made for the associated
%                     rectangle in s.rects
%     ...
%     additional fields from ST passed
%     ...
%
%   If there is a problem at any point during file parsing or structure
%   creation, an appropriate error is returned to the caller.


% CVS INFO %
%%%%%%%%%%%%
% $Id: parse_jlog.m,v 1.1 2003-07-29 21:01:22 scottl Exp $
% 
% REVISION HISTORY:
% $Log: parse_jlog.m,v $
% Revision 1.1  2003-07-29 21:01:22  scottl
% Initial revision.
%


% LOCAL VARS %
%%%%%%%%%%%%%%

% jlog file specifics (update these as the jlog file spec. changes)
separator = '---';  % used to denote the start of a selection

% first do some argument sanity checking on the argument(s) passed
error(nargchk(2,2,nargin));

if iscell(file) | ~ ischar(file) | size(file,1) ~= 1
    error('FILE must contain a single string.');
end

if ~ isfield(st, 'rects')
    error(strcat('ST passed must contain a rects field with selections ', ...
          'obtained via a call to parse_jtag'));
end


% attempt open the arg and read in its header information
fid = fopen(file);

if fid == -1
    error('unable to open FILE.');
end

s = st;
s.jlog_file = file;

% skip over all header lines until we get to the first selection
while ~ feof(fid) 
    line = parse_line(fgetl(fid));
    if strcmp(deblank(line), separator)
        break;
    end
end

% now loop to parse and add each of the selections, should be in multiples
% of 4 (5 including the separator)
s.sel_time   = nan + zeros(size(s.rects, 1), 1);
s.class_time = nan + zeros(size(s.rects, 1), 1);
s.attempts   = nan + zeros(size(s.rects, 1), 1);

while ~ feof(fid)

    pos_line    = parse_line(fgetl(fid));
    sel_line    = parse_line(fgetl(fid));
    class_line  = parse_line(fgetl(fid));
    attmpt_line = parse_line(fgetl(fid));

    data = str2num([pos_line(2:5,:)]);
    data = data';

    % must loop to find the matching rectangle, and fill the other fields
    % at the same position as rects

    found = false;
    for i=1:size(s.rects,1)
        if s.rects(i,:) == data
            found = true;
            break;
        end
    end

    if ~ found
        error(strcat('Could not find match in jtag struct ST for: ', ...
              num2str(data)));
    end

    % add this selection's data to the arrays
    s.sel_time(i, :) = str2num(sel_line(2));
    s.class_time(i, :) = str2num(class_line(2));
    s.attempts(i, :) = str2num(attmpt_line(2));

    % next line must be a separator (if more lines exist)
    fgetl(fid);

end

% close the file
fclose(fid);



% SUBFUNCITON DECLARATIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function res = parse_line(in)
% PARSE_LINE subfunction that takes a single line, strips its comments,
%            removes the '=' character if it exists, and returns all of its 
%            remaining non-whitespace elements as elemnts of a column array (or 
%            the empty string if IN is blank).

if ~ ischar(in)
    error('IN is not a string.');
end

if isempty(in)
    res = in;
    return;
else
    res = [];
end

% strip all characters after (and including) the comment char
commentpos = regexp(in, '#', 'once');
if ~ isempty(commentpos)
    if commentpos > 1
       in = ddeblank(in(1 : commentpos - 1));
    else
       return;
    end
end

% loop over each whitespace delimited token, adding it to res (drop the '=')
% though
[curr, rest] = strtok(in);
while ~ isempty(rest)
    if ~ strcmp(ddeblank(curr), '=')
        res = strvcat(res, curr);
    end
    [curr, rest] = strtok(rest);
end
if ~ strcmp(ddeblank(curr), '=')
    res = strvcat(res, curr);
end