clear;clc;
[tar fs] = audioread('./data/e.wav');
tar = sum(tar, 2) / size(tar, 2);
tar = tar/max(tar);
env = extract_env(tar,fs);
env = env/max(env);
parStft.anaHop = 24;
parStft.win = win(4096,1);
X = stft(tar,parStft);
envX2Y  = repmat(env(:),1,size(X,2));

parIstft.synHop = 24;
parIstft.win = win(4096,1);
parIstft.zeroPad = 0;
parIstft.numOfIter = 1;
parIstft.origSigLen = size(tar,1);
y = istft(X,parIstft);
