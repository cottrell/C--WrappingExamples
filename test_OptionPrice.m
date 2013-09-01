% test_OptionPrice.m
% 	A simple test script to price a European Call option using 
% 		OptionPriceMexWrapper


% mexmake 	% uncomment this to recompile before the script runs.

!rm EuropeanOption.log

T       = 1
S0      = 100
K       = 100
N       = 2^12
sigma 	= 0.2

% option 1: u*d = 1
dt = T/N;
s = sigma*sqrt(dt)
A = 1+s^2/2;
u = A + sqrt(A^2-1)
%u = exp(s); %%% TRY THIS APPROXIMATION
d = 1/u
p = (1-d)/(u-d)
in1=[N,T,u,d,p,S0,K];
out1 = OptionPriceMexWrapper([N,T,u,d,p,S0,K]);
disp(['The CRR construction gives: ',num2str(out1)])

% option 2: p=q=0.5
dt = T/N;
s = sigma*sqrt(dt)
p = 0.5
u = 1+s
d = 1-s
% u = exp(s-s^2/2); %%% TRY THIS APPROXIMATION
% d = exp(-s-s^2/2);
in2=[N,T,u,d,p,S0,K];
out2 = OptionPriceMexWrapper(in2);
disp(['The JR construction gives: ',num2str(out2)])
