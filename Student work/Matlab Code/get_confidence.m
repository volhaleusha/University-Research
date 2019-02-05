function conf = get_confidence(s,cl,drops)

       length = max(size(s));
       mu = mean(s);
       v = var(s);
       
       df = length-1;
       
       crit_value=tinv(0.5+cl/2,df);
       temp = sum(crit_value*sqrt(s)/sqrt(length))/ drops;
       
       lower = mu-temp;
       upper = mu+temp;
       str = [num2str(100*cl), '% confidence interval is:'];
       disp(str);
       disp([lower, mu, upper]);
       conf= [lower, mu, upper];