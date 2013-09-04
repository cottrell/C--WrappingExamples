%module EuropeanOption
%{
#define SWIG_FILE_WITH_INIT
#include "EuropeanOption.h"
%}

double OptionPrice(const int N, const double T, const double u, const double d, const double p, const double S0, const double K);

/* haven't got automatic swigging from header working yet ...
%module EuropeanOption
%{
#define SWIG_FILE_WITH_INIT
#include "EuropeanOption.h"
%}

#include "EuropeanOption.h"
*/
