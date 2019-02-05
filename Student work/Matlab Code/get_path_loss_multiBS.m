function [pl] = get_path_loss_multiBS(distance, kind)
    fc = 3.4;
   
    if strcmpi(kind, 'los')
        pl = 16.9 .* log10(distance) + 32.8 + 20 .* log10(fc);
    elseif strcmpi(kind, 'nlos')
        pl = 43.3 .* log10(distance) + 11.5 + 20 .* log10(fc);
    end