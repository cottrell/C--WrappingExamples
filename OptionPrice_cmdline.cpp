#include        <stdlib.h>
#include        <iostream>
#include        "EuropeanOption.h"

int main ( int argc, char *argv[] )
{
        const int numinputs = 7;

        if ( argc != numinputs+1 ) {
                cout << "Error: " << argc-1 << " inputs given, " << numinputs << " required." << endl;
		cout << "Usage: OptionPrice_cmdline N T u d p S0 K" << endl;
                exit(1);
        }

	int N;
	double T,u,d,p,S0,K;

        N = atoi(argv[1]);
        T = atof(argv[2]);
        u = atof(argv[3]);
        d = atof(argv[4]);
        p = atof(argv[5]);
        S0 = atof(argv[6]);
        K = atof(argv[7]);

        double a = OptionPrice(N,T,u,d,p,S0,K);

        cout << "The Option Price is: " << a << endl;

        return EXIT_SUCCESS;
}
