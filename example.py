from pylab import *
import EuropeanOption as EO

def f(N=1000, T=5., u=1.01, d=1./1.01, p=0.48, S0=100., K=50.):
    return(EO.OptionPrice(N, T, u, d, p, S0, K))

ds = linspace(-50, 10, 50)

S = 100 + ds
y = [f(S0 = x) for x in S]
print(y)

figure(1)
clf()
plot(S, y)
grid()
xlabel('S')
ylabel('Price')

savefig('plot.png')
