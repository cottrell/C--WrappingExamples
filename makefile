all: test_OptionPrice OptionPrice_cmdline

mex: OptionPriceMexWrapper

OptionPriceMexWrapper: OptionPriceMexWrapper.cpp
	matlab -nodesktop < mexmake.m > mexmake.log

test_OptionPrice: test_OptionPrice.o EuropeanOption.o
	g++ test_OptionPrice.o EuropeanOption.o -o test_OptionPrice

test_OptionPrice.o: test_OptionPrice.cpp EuropeanOption.h
	g++ -c test_OptionPrice.cpp

OptionPrice_cmdline: OptionPrice_cmdline.o EuropeanOption.o
	g++ OptionPrice_cmdline.o EuropeanOption.o -o OptionPrice_cmdline

OptionPrice_cmdline.o: OptionPrice_cmdline.cpp EuropeanOption.h
	g++ -c OptionPrice_cmdline.cpp

EuropeanOption.o: EuropeanOption.cpp EuropeanOption.h
	g++ -c EuropeanOption.cpp

clean:
	rm -rf *.o *.log *.mex* test_OptionPrice OptionPrice_cmdline
