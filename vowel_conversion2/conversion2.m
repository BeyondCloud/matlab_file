[src fs] = audioread('./data/a.wav');
src = sum(src, 2) / size(src, 2);
src = src/max(src);
envX = extract_env(src,fs);
envX = envX/max(envX);

f=(0:fs/(4096-1):fs);
f = f(1:4096/2+1);
figure;plot(f,envX);

[tar fs] = audioread('./data/e.wav');
tar = sum(tar, 2) / size(tar, 2);
tar = tar/max(tar);
envY = extract_env(tar,fs);
envY = envY/max(envY);

% X2Y = db2mag(envY)./db2mag(envX);
X2Y = envY./envX;
X2Y(300:end) = 1;

parStft.anaHop = 24;
parStft.win = win(4096,1);
X = stft(src,parStft);
envX2Y  = repmat(X2Y(:),1,size(X,2));
X_specEnvY = X.*envX2Y;

parIstft.synHop = 24;
parIstft.win = win(4096,1);
parIstft.zeroPad = 0;
parIstft.numOfIter = 1;
parIstft.origSigLen = size(src,1);
y = istft(X_specEnvY,parIstft);