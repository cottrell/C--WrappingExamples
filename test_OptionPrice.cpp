#include	<stdlib.h>
#include	<iostream>
#include	"EuropeanOption.h"

int main ( int argc, char *argv[] )
{
	double a = OptionPrice(10,1.0,1.1,0.9,0.4,100,100);

	cout << "The Option Price is: " << a << endl;

	return EXIT_SUCCESS;
}				/* ----------  end of function main  ---------- */
