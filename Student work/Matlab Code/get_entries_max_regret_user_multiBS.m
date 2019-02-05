function [opt] = get_entries_max_regret_user_multiBS(fap, common, kind)

if strcmpi(kind, '2FAPs')
    [opt] = get_entries_max_regret_multiBS_2FAPs(fap, common);
elseif strcmpi(kind, '3FAPs')
    [opt] = get_entries_max_regret_user_multiBS_3FAPs(fap, common);
elseif strcmpi(kind, '4FAPs')
    [opt] = get_entries_max_regret_user_multiBS_4FAPs(fap, common);
end