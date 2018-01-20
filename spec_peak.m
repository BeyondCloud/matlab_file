[x Fs]  = audioread('my_a.wav');
parStft.anaHop = 512;
parStft.win = win(2048,1);
X = stft(x,parStft);
envX = compEnv(X,60);
function env = compEnv(X,filLen)

    kern = win(filLen,2); % Hann window
    env = conv2(abs(X),kern,'same');

    % Scale the envelope such that the largest value of the envelope
    % coincides with the largest value of the spectrum (this is a
    % heuristic). We therfore first normalize the envelope such that the
    % largest value is 1 and afterwards multiply with the largest value of
    % the respective spectral frame.

    env = env ./ repmat(max(env),size(env,1),1); % normalization
    env = env .* repmat(max(abs(X)),size(abs(X),1),1); % scaling

    % avoid values close to zero

    env(env<10^-2) = 10^-2;

end