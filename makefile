all: swig test_OptionPrice OptionPrice_cmdline

# just use distutils and swig
swig: EuropeanOption_wrap.cxx
	python3 setup.py build_ext --inplace
	python3 example.py # run the example

EuropeanOption_wrap.cxx: EuropeanOption.cpp EuropeanOption.i
	swig -c++ -python EuropeanOption.i

# _EuropeanOption.so: EuropeanOption_wrap.o
# 		g++ -bundle `python-config --ldflags` EuropeanOption.o EuropeanOption_wrap.o -o _EuropeanOption.so
# EuropeanOption_wrap.o: EuropeanOption_wrap.cxx
# 		g++ -c `python-config --cflags` EuropeanOption.cpp EuropeanOption_wrap.cxx


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
	rm -rf __pycache__ *_wrap* build *.o *.so *.log *.mex* test_OptionPrice OptionPrice_cmdline
