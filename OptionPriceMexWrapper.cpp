#include 	<math.h>
#include 	"mex.h"
#include 	"EuropeanOption.h"

// compile in MATLAB with:
// 		mex -v OptionPriceMexWrapper.cpp EuropeanOption.cpp
// or using scriptfile the
// 		mexmake.m

using namespace std;

void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[] )
{
	int mrowsx,ncolsx,N;
	double *output,*x,T,u,d,p,S0,K;

	// Check for proper number of arguments.
	if(nrhs!=1) {
		mexErrMsgTxt("One input vector required.");
	} else if(nlhs>1) {
		mexErrMsgTxt("Too many output arguments.");
	}

	// The input must be a noncomplex vector double.
	mrowsx = mxGetM(prhs[0]);
	ncolsx = mxGetN(prhs[0]);

	// Check that inputs are of correct dimension
	if( !mxIsDouble(prhs[0]) || mxIsComplex(prhs[0])) {
		mexErrMsgTxt("Input must be a noncomplex scalar double.");
	}
	if( ( mrowsx * ncolsx ) != 7  ) {
		mexErrMsgTxt("The argument vector must have 7 entries.");
	}

	// Create matrix for the return argument.
	plhs[0] = mxCreateDoubleMatrix(1,1, mxREAL);

	// Assign pointers to each input and output.
	x = mxGetPr(prhs[0]);
	output = mxGetPr(plhs[0]);

	// Assign the values for readability
	N = (int) *x; // cast double as int for convenience of having a single vector input from matlab
	T = *(x+1);
	u = *(x+2);
	d = *(x+3);
	p = *(x+4);
	S0 = *(x+5);
	K = *(x+6);

	// for testing
	// mexPrintf("Mex Matlab: %d %f %f %f %f %f %f",N,T,u,d,p,S0,K);

	// Call the OptionPrice function.
	*output = OptionPrice(N,T,u,d,p,S0,K);

}
