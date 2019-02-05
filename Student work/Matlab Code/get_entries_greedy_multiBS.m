function [opt] = get_entries_greedy_multiBS(fap, common, kind)


% depending of kind chooses the right function to find greedy solution
if strcmpi(kind, '2FAPs')
    [opt] = get_entries_greedy_multiBS_2FAPs(fap, common);
elseif strcmpi(kind, '3FAPs')
    [opt] = get_entries_greedy_multiBS_3FAPs(fap, common);
elseif strcmpi(kind, '4FAPs')
    [opt] = get_entries_greedy_multiBS_4FAPs(fap, common);
end
