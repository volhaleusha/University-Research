function thrLTE_fap = rateLTE_multiBS(CIR_fap,kind)

if strcmpi(kind, '2FAPs')
     thrLTE_fap = rateLTE_multiBS_2FAPs(CIR_fap);
elseif strcmpi(kind, '3FAPs')
     thrLTE_fap = rateLTE_multiBS_3FAPs(CIR_fap);
elseif strcmpi(kind, '4FAPs')
     thrLTE_fap = rateLTE_multiBS_4FAPs(CIR_fap);
end