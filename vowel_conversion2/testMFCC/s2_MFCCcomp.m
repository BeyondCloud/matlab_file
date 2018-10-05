nfft = 4096;
from = 1000;
A = abs(fft(a(from:from+nfft-1)));
E = abs(fft(e(from:from+nfft-1)));
A_T = abs(fft(a_t(from:from+nfft-1)));
E_T = abs(fft(e_t(from:from+nfft-1)));

A = A(1:nfft/2+1);
E = E(1:nfft/2+1);
A_T = A_T(1:nfft/2+1);
E_T = E_T(1:nfft/2+1);

Ac = H2*A;
plot(Ac);
Ec = H2*E;
figure;
plot(Ec);

A_Tc = H2*A_T;
figure;
plot(A_Tc);

E_Tc = H2*E_T;
figure;
plot(E_Tc);
