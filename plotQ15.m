%	Price an option using c++/mex code.
%	figure 1: Plot the results as a function of 1/(Delta t)
%	figure 2: Plot the computation time as a funciton of 1/(Delta t)
%
%	Depends on
%		C++ source files:
%			OptionPriceMexWrapper.cpp
%			EuropeanOption.h
%			EuropeanOption.cpp
%		matlab .m files:
%			f1.m
%			f2.m
%
%	To compile .cpp with mex:
%		mex -v OptionPriceMexWrapper.cpp EuropeanOption.cpp
%	or	mexmake % (this is a script ./mexmake.m )
%

!rm EuropeanOption.log		% remove the logfile produced by PriceOption function


% if calc_err_using_exact_result 1, plot Error = abs(V0 -Vexact)
% if calc_err_using_exact_result 0, use relative difference
calc_err_using_exact_result = 1

%% PARAMETERS TO CHANGE
% these variables are the same in both the CRR and JR case
T 	= 1
S0	= 100
K	= 100
sigma 	= 0.2

% change the ranges here
Nvec	= 2.^[4:16];
%% END PARAMETERS TO CHANGE

Vexact = 7.965579;

dtvec	= T./Nvec;

% assemble the information for plotting
V1 = []; V2 = [];
t1 = []; t2 = [];
for i=1:length(Nvec)
	tic
	V1 = [V1 f1(sigma,Nvec(i),T,S0,K)];
	t1 = [t1 toc];
	tic
	V2 = [V2 f2(sigma,Nvec(i),T,S0,K)];
	t2 = [t2 toc];
end

figure(1),clf
subplot(2,1,1)
if calc_err_using_exact_result
	h1=semilogx(1./dtvec,dtvec*0+Vexact,'k-');hold on
end
h2=semilogx(1./dtvec,V1,'bo-');hold on
h3=semilogx(1./dtvec,V2,'go-');
if calc_err_using_exact_result
	legend('exact','ud=1','p=q=0.5','Location','Best')
else
	legend('ud=1','p=q=0.5','Location','Best')
end
xlim([min(1./dtvec),max(1./dtvec)])
ylabel 'V_0'
dtvec2 = dtvec(2:end);
V1reldiff = abs(diff(V1))./V1(1:(end-1));
V2reldiff = abs(diff(V2))./V2(1:(end-1));
V1exacterr = abs(V1-Vexact);
V2exacterr = abs(V2-Vexact);
if calc_err_using_exact_result
	V1err = V1exacterr;
	V2err = V2exacterr;
else
	V1err = V1reldiff;
	V2err = V2reldiff;
end
subplot(2,1,2)
loglog(1./dtvec2,V1reldiff,'bo-'),hold on
loglog(1./dtvec2,V2reldiff,'go-')
temp=1./dtvec(round(0.5*end):round(0.8*end));
slope=-1;
tempy=1*temp.^(slope);
loglog(temp,tempy,'k:')
text(temp(round(end/2)),2*tempy(round(end/2)),['slope = ',num2str(slope)])
xlim([min(1./dtvec2),max(1./dtvec2)])
xlabel '1/\Delta t = N/T'
ylabel '|Error|'

figure(2),clf
loglog(1./dtvec,t1,'bo-'),hold on
loglog(1./dtvec,t2,'go-'),hold on
temp=1./dtvec(round(0.6*end):round(0.8*end));
slope = 2;
tempy=1e-8*temp.^(slope);
loglog(temp,tempy,'k:')
text(0.35*temp(round(end/2)),1*tempy(round(end/2)),['slope = ',num2str(slope)])
xlim([min(1./dtvec),max(1./dtvec)])
ylabel 'Computing time'
xlabel '1/\Delta t = N/T'
legend('ud=1','p=q=0.5','Location','Best')

