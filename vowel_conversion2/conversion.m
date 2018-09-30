clear;clc
[xa fs] = audioread('./data/a_tar.wav');
xa = sum(xa, 2) / size(xa, 2);
xa = xa/max(xa);
envX2 = extract_env(xa,fs);

[xe fs] = audioread('./data/e_tar.wav');
xe = sum(xe, 2) / size(xe, 2);
xe = xe/max(xe);
envY2 = extract_env(xe,fs);

%interpolate at log domain to prevent negative interp value
X2Y = db2mag(envY2)./db2mag(envX2);
% X2Y = envY2./envX2;

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