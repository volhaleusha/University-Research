
function [CIR_fap CIR_common] = get_CIR_multiBS(pl, nodes, kind)


% depending of kind chooses the right function to find SINR
 
if strcmpi(kind, '2FAPs')
    [CIR_fap CIR_common] = get_CIR_multiBS_2FAPs(pl, nodes);
elseif strcmpi(kind, '3FAPs')
    [CIR_fap CIR_common] = get_CIR_multiBS_3FAPs(pl, nodes);
elseif strcmpi(kind, '4FAPs')
    [CIR_fap CIR_common] = get_CIR_multiBS_4FAPs(pl, nodes);
end    
