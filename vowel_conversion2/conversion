clear;clc
[xa fs] = audioread('./data/a.wav');
xa = sum(xa, 2) / size(xa, 2);
xa = xa/max(xa);
envX = extract_env(xa,fs);

[xe fs] = audioread('./data/e.wav');
xe = sum(xe, 2) / size(xe, 2);
xe = xe/max(xe);
envY = extract_env(xe,fs);

X2Y = db2mag(envY)./db2mag(envX);

parStft.anaHop = 24;
parStft.win = win(4096,1);
X = stft(xa,parStft);
envX2Y  = repmat(X2Y(:),1,size(X,2));
X_specEnvY = X.*envX2Y;

parIstft.synHop = 24;
parIstft.win = win(4096,1);
parIstft.zeroPad = 0;
parIstft.numOfIter = 1;
parIstft.origSigLen = size(xa,1);
y = istft(X_specEnvY,parIstft);