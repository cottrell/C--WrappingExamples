#include	<vector>
#include	<math.h>
#include 	<iostream>
#include	<fstream> 		// for ofstream output to the log file
#include	<float.h> 		// for access to DBL_MAX_EXP and DBL_MIN_EXP
#include	"EuropeanOption.h"

using namespace std;

double OptionPrice(const int N, const double T, const double u, const double d, const double p, const double S0, const double K)
{

	ofstream logfile; 	// write log data here (for debugging and testing)
	logfile.open("EuropeanOption.log",ios::app);

	// some logicals for ensuring the parameters are safe
	const bool OVER_MAX = (N*log2(u) >= DBL_MAX_EXP), \
			      UNDER_MIN =(N*log2(d) <= DBL_MIN_EXP), \
			      d_IS_NONPOSITIVE = (d <= 0);

	// Check for under or overflow of stock price.
	// 	For a general payoff, we should also check that the
	// 	payoff values do not lead to over/under flow. This check
	// 	would have to be given by the user providing the payoff function.
	if ( OVER_MAX || UNDER_MIN || d_IS_NONPOSITIVE){
		logfile << "OptionPrice -----------------" << endl;
		if (OVER_MAX) {
			logfile << "\t Error: u^N <= MAX_DBL with u = " << u << " and N = " << N << endl;
		}
		if (UNDER_MIN) {
			logfile << "\t Error: u^N <= MIN_DBL with d = " << d << " and N = " << N  << endl;
		}
		if (d_IS_NONPOSITIVE) {
			logfile << "\t Error: d = " << d << " is non-positive!" << endl;
		}
		return NAN; // comment this out if you want to see the results with overflow, underflow or d<0
	}
	// otherwise proceed with the calculation
	else {
		vector<double> V; 				// use this vector for both stock and option values

		V.resize(N+1);
		unsigned int i,j;
		V[0] = S0*pow(d,N);

		for (i=1;i<(N+1);i++) {               		// assign prices of the stock after N steps
			V[i] = V[i-1]*u/d;
		}

		for (i=0;i<(N+1);i++) {               		// initialize option values at time T
			V[i] = payoff(V[i],K);
		}

		for (j=N;j>0;j--){            			// loop through the vertices at level j
			for (i=0;i<j;i++){
				V[i] = p*V[i+1]+(1-p)*V[i]; 	// pricing formula: recall risk-free rate r=0
			}
			V.pop_back(); 				// throw away "top" entry, reduce size of V by one
		}

		logfile.close(); 				// close the ofstream logfile

		return V[0];
	}

} // end double OptionPrice( ... )


double payoff(const double S, const double K){

	return max(S-K,0.0);	// the payoff for a European call optiob

} // end double payoff( ... )
