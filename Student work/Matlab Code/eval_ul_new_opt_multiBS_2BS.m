clear

maxNodes = 10;

xesCIR = -50:0.1:100;
histGrCIR = zeros(1, length(xesCIR));
histMaxRegCIR = zeros(1, length(xesCIR));
histRCIR = zeros(1, length(xesCIR));

xesThrLTE = 0:20000:4E7;
xesThrSh = 0:20000:20E7;

histGrThrLTE = zeros(1, length(xesThrLTE));
histMaxRegThrLTE = zeros(1, length(xesThrLTE));
histMaxRegUserThrLTE = zeros(1, length(xesThrLTE));
histRThrLTE = zeros(1, length(xesThrLTE));
histRThrLTE_repeat = zeros(1, length(xesThrLTE));
histOptimalThrLTE = zeros(1, length(xesThrLTE));
histOptimalThrLTE_Brute = zeros(1, length(xesThrLTE));

winner_Gr = 0;
winner_Rand = 0;
winner_MaxReg = 0;
winner_MaxRegUser = 0;


histGrThrSh = zeros(1, length(xesThrSh));
histMaxRegThrSh = zeros(1, length(xesThrSh));
histMaxRegUserThrSh = zeros(1, length(xesThrSh));
histRThrSh = zeros(1, length(xesThrSh));


for d = 4; %:maxNodes
    
    % Nodes per system (UTs for each BS)
    nodes = d;
    % Number of BS
    
    faps= 2;  
    rcell=100;
    dinter=-75;
    rinter =2*dinter;
    
    k='2FAPs';

    % Number of drops with different node positions in each drop
    drops = 1000;    
    B=17.28E6;

    seGrLTE = 0;
    seRand_LTE = 0;
    seRand_LTE_repeat =0;
    seMaxReg_LTE = 0;
    seMaxRegUser_LTE = 0;
    seOptimal_LTE = 0;
    seOptimal_LTE_Brute = 0;
    seGrSh = 0;
    seRand_Sh = 0;
    seMaxReg_Sh = 0;
    seMaxRegUser_Sh = 0;
    pl1=0;
    dist1=0;
    
    tic
    s1 = zeros(1, drops);
    s2 = zeros(1, drops);
    s3 = zeros(1, drops);
    s4 = zeros(1, drops);
    s5 = zeros(1, drops);
    t1 = zeros(1, drops);
    t2 = zeros(1, drops);
    t3 = zeros(1, drops);
    t4 = zeros(1, drops);
    for i = 1:drops
        i
        if mod(i, 10) == 0
            i / drops  * 100
        end
        

        % Get coordinates for each Base Station (faps is number of base
        % stations)
        
        [xfap, yfap]= get_FAPs_coord (faps, rcell, rinter);
        
        % Get node positions for both systems
        
        [x, y] = get_InH_UTs_multiBS(nodes, xfap, yfap, rcell, faps);       
        plot(x(:),y(:),'*')
%         axis equal;
        
        % Get the distances of each node to each BS and from there the
        % pathlosses
        
        [distance]= get_distance_multiBS(x, y, xfap, yfap, faps);
        
        % Get pathloss for each UT and BS combination:
        
        pl = get_path_loss_multiBS(distance, 'nlos');
% 
%         pl1=pl1+(sum(sum(sum(pl/d))/(faps^2)))/drops;
%         dist1=dist1+(sum(sum(sum(distance/d)))/(faps^2))/drops;
%         
%     end        
%     pl1
%     dist1
    
    
      % Get CIR for each system and each combination (possible variations-
      % 2FAPs, 3FAPs, 4FAPs)
       
       [CIR_fap, CIR_common] = get_CIR_multiBS(pl, nodes,k);
      
       thrLTE_fap = rateLTE_multiBS(CIR_fap,k)./nodes;
       thrLTE_common = get_common_multiBS(thrLTE_fap, nodes,k);

%        
%        r_fap = rateShannon_multiBS(CIR_fap, B)./ nodes;
%        r_common = rateShannon_multiBS_common(r_fap, nodes,k); 
% 
%     
         
       
       tic
       optGr_LTE = get_entries_greedy_multiBS(thrLTE_fap, thrLTE_common, k);   
       t1(i) = toc;
       
       tic
       optRand_LTE = get_entries_random_multiBS(thrLTE_fap, thrLTE_common, k);
       t2(i) = toc;
       
       tic
       optMaxReg_LTE = get_entries_max_regret_multiBS(thrLTE_fap, thrLTE_common, k);
       t3(i) = toc;
%
       
%        tic
%        optMaxRegUser_LTE = get_entries_max_regret_user_multiBS(thrLTE_fap,thrLTE_common, k);
%        t4(i) = toc;
       
%        tic
%        optOptimal_LTE = blabla(thrLTE_fap,thrLTE_common, k);
%        t5(i) = toc;
%        
                    
       tic
       optOptimal_LTE = get_entries_optimalHung_multiBS(thrLTE_fap, thrLTE_common);  
       t5(i) = toc;
       
      
% 
% 
%        opt_common_old=0;
%       
%        for m=1:1000
%            
%         optRand_LTE_test= get_entries_random_multiBS(thrLTE_fap, thrLTE_common, k);
%         opt_common = sum(optRand_LTE_test);
%         if opt_common >= opt_common_old
%               optRand_LTE_repeat = optRand_LTE_test;
%               opt_common_old = opt_common;
%         end 
%        end
       
       win_Gr = get_winner(optGr_LTE,optRand_LTE,optMaxReg_LTE,0);
       win_Rand = get_winner(optRand_LTE,optGr_LTE,optMaxReg_LTE,0);
       win_MaxReg = get_winner(optMaxReg_LTE,optRand_LTE,optGr_LTE,0);
      % win_MaxRegUser = get_winner(optMaxRegUser_LTE,optRand_LTE,optMaxReg_LTE,optGr_LTE);
       

       seGrLTE = seGrLTE + sum(optGr_LTE) ./ (faps * B);
       seRand_LTE = seRand_LTE + sum(optRand_LTE) ./ (faps * B);
     %  seRand_LTE_repeat = seRand_LTE_repeat + sum(optRand_LTE_repeat) ./ (faps * B);
       seMaxReg_LTE = seMaxReg_LTE + sum(optMaxReg_LTE) ./ (faps * B);
    %   seMaxRegUser_LTE = seMaxRegUser_LTE + sum(optMaxRegUser_LTE) ./ (faps * B);
      seOptimal_LTE = seOptimal_LTE + sum(optOptimal_LTE) ./ (faps * B);
      % seOptimal_LTE_Brute = seOptimal_LTE_Brute + sum(optOptimal_LTE_Brute) ./ (faps * B);
       
       
       s1(i) = sum(optGr_LTE) ./ (faps * B);
       s2(i) = sum(optRand_LTE) ./ (faps * B);
    %   s3(i) = sum(optRand_LTE_repeat) ./ (faps * B);
       s4(i) = sum(optMaxReg_LTE) ./ (faps * B);
     %  s5(i) = sum(optMaxRegUser_LTE) ./ (faps * B);
      s6(i) = sum(optOptimal_LTE) ./ (faps * B);
     %  s7(i) = sum(optOptimal_LTE_Brute) ./ (faps * B);
     
     
       winner_Gr = winner_Gr + win_Gr;
       winner_Rand = winner_Rand + win_Rand;
       winner_MaxReg = winner_MaxReg + win_MaxReg;
     %  winner_MaxRegUser = winner_MaxRegUser + win_MaxRegUser;
   
     
       
   
       
       histGrThrLTE = histGrThrLTE + hist(optGr_LTE, xesThrLTE) ./ (faps * nodes);
       histRThrLTE = histRThrLTE + hist(optRand_LTE, xesThrLTE) ./ (faps * nodes);   
    %  histRThrLTE_repeat = histRThrLTE_repeat + hist(optRand_LTE_repeat, xesThrLTE) ./ (faps * nodes);   
       histMaxRegThrLTE = histMaxRegThrLTE + hist(optMaxReg_LTE, xesThrLTE) ./ (faps * nodes);
     %  histMaxRegUserThrLTE = histMaxRegUserThrLTE +hist(optMaxRegUser_LTE, xesThrLTE) ./ (faps * nodes);
     histOptimalThrLTE = histOptimalThrLTE + hist(optOptimal_LTE, xesThrLTE) ./ (faps * nodes);
     %  histOptimalThrLTE_Brute = histOptimalThrLTE_Brute + hist(optOptimal_LTE_Brute, xesThrLTE) ./ (faps * nodes);
    
     end
    toc
   
      % confidence interval for 95%:
       cl=0.95;
       conf_Gr = get_confidence(s1, cl,drops);    
       conf_RTh = get_confidence(s2, cl,drops);
      % conf_RTh_repeat = get_confidence(s3, cl,drops);
       conf_MaxReg = get_confidence(s4, cl,drops);
      % conf_MaxRegUser = get_confidence(s5, cl,drops);
      conf_OptimalUser = get_confidence(s6, cl,drops);
       
       %histOptimalThrLTE = histOptimalThrLTE./drops;     
       
%        seGrLTE_d_d(d) = seGrLTE ./ drops;
%        seRand_LTE_d_d(d) = seRand_LTE ./ drops;
%        seRand_LTE_repeat_d_d(d) = seRand_LTE_repeat ./ drops;
%        seMaxReg_LTE_d_d(d)= seMaxReg_LTE ./ drops;
%        seMaxRegUser_LTE_d_d(d)= seMaxRegUser_LTE ./ drops;  
       
       winner_Gr_d= winner_Gr /(winner_Gr+winner_Rand+winner_MaxReg+winner_MaxRegUser);
       winner_Rand_d =  winner_Rand/(winner_Gr+winner_Rand+winner_MaxReg+winner_MaxRegUser);
       winner_MaxReg_d = winner_MaxReg/(winner_Gr+winner_Rand+winner_MaxReg+winner_MaxRegUser);
      % winner_MaxRegUser_d = winner_MaxRegUser/(winner_Gr+winner_Rand+winner_MaxReg+winner_MaxRegUser);
       
  
       
       histGrThrLTE = histGrThrLTE ./ drops;   
       histRThrLTE = histRThrLTE ./ drops;
   %   histRThrLTE_repeat = histRThrLTE_repeat./ drops;  
       histMaxRegThrLTE = histMaxRegThrLTE ./ drops;
     % histMaxRegUserThrLTE = histMaxRegUserThrLTE./ drops;
      histOptimalThrLTE = histOptimalThrLTE ./ drops;
     %  histOptimalThrLTE_Brute = histOptimalThrLTE_Brute./ drops;
      
       
       seGrLTE_d = seGrLTE ./ drops;
       seRand_LTE_d = seRand_LTE ./ drops;
     % seRand_LTE_repeat_d = seRand_LTE_repeat ./ drops;
       seMaxReg_LTE_d= seMaxReg_LTE ./ drops;
    %  seMaxRegUser_LTE_d= seMaxRegUser_LTE ./ drops;
       seOptimal_LTE_d= seOptimal_LTE ./ drops;
   %    seOptimal_LTE_Brute_d= seOptimal_LTE_Brute ./ drops; 
       
  
   end


% plot(xesThrSh, cumsum(histGrThrSh), xesThrSh, cumsum(histRThrSh),xesThrSh, cumsum(histMaxRegThrSh),xesThrSh, cumsum(histMaxRegUserThrSh))
%plot(xesThrLTE, cumsum(histGrThrLTE), xesThrLTE, cumsum(histRThrLTE), xesThrLTE, cumsum(histRThrLTE_repeat),xesThrLTE, cumsum(histMaxRegThrLTE), xesThrLTE, cumsum(histMaxRegUserThrLTE))
% plot( xesThrLTE, cumsum(histMaxRegThrLTE),xesThrLTE, cumsum(histMaxRegUserThrLTE))
% plot(xesThrSh, cumsum(histGrThrSh))
% plot(xesThrLTE,cumsum(seGrLTE_d),'.-',xesThrLTE,cumsum(seRand_LTE_d),'o-',xesThrLTE,cumsum(seMaxReg_LTE_d),'s-',xesThrLTE,cumsum(seMaxRegUser_LTE_d),'*');
% 
%a= [seGrLTE_d, seRand_LTE_d, seRand_LTE_repeat_d, seMaxReg_LTE_d ,seMaxRegUser_LTE_d]
a= [seGrLTE_d, seRand_LTE_d,  seMaxReg_LTE_d,seOptimal_LTE_d ]

    %,seOptimal_LTE_d]
%b= [seGrSh_d, seRand_Sh_d,seMaxReg_Sh_d,seMaxRegUser_Sh_d]
t= [mean(t1), mean(t2), mean(t3),mean(t5)]
w = [winner_Gr_d,winner_Rand_d,winner_MaxReg_d]

   