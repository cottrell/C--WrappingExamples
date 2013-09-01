function out = f1(sigma,N,T,S0,K)
	% A function to call the OptionPrice routine using the
	% CRR construction ( u*d = 1 )
	dt = T/N;
	s = sigma*sqrt(dt);
	A = 1+s^2/2;
	u = A + sqrt(A^2-1);
	d = 1/u;
	p = (1-d)/(u-d);
	out = OptionPriceMexWrapper([N,T,u,d,p,S0,K]);
end
