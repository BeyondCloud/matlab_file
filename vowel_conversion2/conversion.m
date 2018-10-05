clear;clc
[src fs] = audioread('./data/a_tar.wav');
src = sum(src, 2) / size(src, 2);
src = src/max(src);
envSrc = extract_env(src,fs);

[tar fs] = audioread('./data/e_tar.wav');
tar = sum(tar, 2) / size(tar, 2);
tar = tar/max(tar);
envTar = extract_env(tar,fs);

%interpolate at log domain to prevent negative interp value
X2Y = db2mag(envTar)./db2mag(envSrc);
% X2Y = envY2./envX2;
% X2Y(300:end) = 1;

parStft.anaHop = 24;
parStft.win = win(4096,1);
X = stft(src,parStft);
envX2Y  = repmat(X2Y(:),1,size(X,2));
X_specEnvY = X.*envX2Y;
plot(mag2db(abs(X_specEnvY(:,1))));
parIstft.synHop = 24;
parIstft.win = win(4096,1);
parIstft.zeroPad = 0;
parIstft.numOfIter = 1;
parIstft.origSigLen = size(src,1);
y = istft(X_specEnvY,parIstft);