fs = 44100;
atk = 18593;
loop_A = 27947;
loop_B = 37883;
[x fs] = audioread('_hao_hao.wav');
result_ms = 1000
y = partial_stretch(x,result_ms,atk,loop_A,loop_B);