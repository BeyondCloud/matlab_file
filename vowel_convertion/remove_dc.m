rx=randn([16,1]);
tnx=fftfilt(rx-mean(rx),tx);