#ifndef EUROPEANOPTION_H
#define EUROPEANOPTION_H

using namespace std;

//===  FUNCTION  ======================================================================
//        Name:  OptionPrice
// Description:  Returns the price of European Call Option priced via a binomial tree.
// 		 Depends on double payoff( ... ) defined below
//=====================================================================================
double OptionPrice(const int N, const double T, const double u, const double d, const double p, const double S0, const double K);

//===  FUNCTION  ======================================================================
//        Name:  payoff
// Description:  The payoff function for a European Call Option.
//=====================================================================================
double payoff(const double S, const double K);

#endif
