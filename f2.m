function out = f2(sigma,N,T,S0,K)                
	% A function to call the OptionPrice routine using the
	% JR construction ( p=q=0.5 )
	dt = T/N;
	s = sigma*sqrt(dt);                
	p = 0.5;
	u = 1+s;                
	d = 1-s;
	out = OptionPriceMexWrapper([N,T,u,d,p,S0,K]);        
