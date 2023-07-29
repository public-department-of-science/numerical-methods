function info = cpuinfo()
  info = cpuInfoWindows();
end
%-------------------------------------------------------------------------%
function info = cpuInfoWindows()
sysInfo = callWMIC( 'cpu' );
disp(sysInfo.Name);
info = struct( ...
    'Name', sysInfo.Name, ...
    'Clock', [sysInfo.MaxClockSpeed,' MHz'], ...
    'Cache', [sysInfo.L3CacheSize,' KB'], ...
    'NumProcessors', str2double( sysInfo.NumberOfCores ), ...
    'OSType', 'Windows');
end
%-------------------------------------------------------------------------%
function info = callWMIC( alias )
% Call the MS-DOS WMIC (Windows Management) command
olddir = pwd();
cd( tempdir );
sysinfo = evalc( sprintf( '!wmic %s get /value', alias ) );
cd( olddir );
fields = textscan( sysinfo, '%s', 'Delimiter', '\n' ); fields = fields{1};
fields( cellfun( 'isempty', fields ) ) = [];
% Each line has "field=value", so split them
values = cell( size( fields ) );
for ff=1:numel( fields )
    idx = find( fields{ff}=='=', 1, 'first' );
    if ~isempty( idx ) && idx>1
        values{ff} = strtrim( fields{ff}(idx+1:end) );
        fields{ff} = strtrim( fields{ff}(1:idx-1) );
    end
end

% Remove any duplicates (only occurs for dual-socket PC's and we will
% assume that all sockets have the same processors in them).
numResults = sum( strcmpi( fields, fields{1} ) );
if numResults>1
    % If we are counting cores, sum them.
    numCoresEntries = find( strcmpi( fields, 'NumberOfCores' ) );
    if ~isempty( numCoresEntries )
        cores = cellfun( @str2double, values(numCoresEntries) );
        values(numCoresEntries) = {num2str( sum( cores ) )};
    end
    % Now remove the duplicate results
    [fields,idx] = unique(fields,'first');
    values = values(idx);
end

% Convert to a structure
info = cell2struct( values, fields );
end