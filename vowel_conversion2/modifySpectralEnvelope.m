function [x_SpecEnvY X_norm] = modifySpectralEnvelope(x,envX2Y)

if nargin<2
    error('Please specify input data x and envX2Y.');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% some pre calculations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
anaHop = 64;
numOfChan = size(x,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% modify the spectral envelopes channel wise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_SpecEnvY = zeros(size(x));            % Initialize output
disp(numOfChan)
for c = 1 : numOfChan                   % loop over channels
xC = x(:,c);

% compute the STFT
parStft.anaHop = anaHop;
parStft.win = win(4096,1);
X = stft(xC,parStft);
envX2Y  = repmat(envX2Y(:),1,size(X,2));

% compute spectral envelopes

X_specEnvY = X.*envX2Y;

% istft
parIstft.synHop = anaHop;
parIstft.win = win(4096,1);
parIstft.zeroPad = 0;
parIstft.numOfIter = 1;
parIstft.origSigLen = size(x,1);
x_SpecEnvY(:,c) = istft(X_specEnvY,parIstft);

end

end



function env = compTE(X,filLen)
filLen = 512 - 20;

% filLen = round(1.66 * filLen);

% numOfBins = size(X,1);
% sizeOfZeroPadding = round(1.66*numOfBins) - numOfBins + mod(round(1.66*numOfBins - numOfBins),2);

numOfIter = 100;

A = log(abs(X));
V = -Inf(size(X));
cInd = floor(size(X,1)/2+1);
for i = 1 : numOfIter
    A = max(A,V);
    C = fft(A);
    C(cInd-filLen:cInd+filLen,:) = 0;
    V = real(ifft(C));
end

env = exp(A);

% %% log freq axis
% % log axis
% linAxis = 1:size(X,1);
% logAxis = exp((linAxis-1)/linAxis(end)*5)-1;
% logAxis = logAxis/logAxis(end)*(linAxis(end)-1)+1;
%
%
% A = log(abs(X));
% A = interp1(linAxis,A,logAxis);
% % A = abs(X);
% V = -Inf(size(X));
% cInd = floor(size(X,1)/2+1);
% for i = 1 : numOfIter
%     A = max(A,V);
%
% %     Xpadded = [A; zeros(sizeOfZeroPadding, size(X,2))];
% %     Xshifted = fftshift(Xpadded,1);
% %     Xwin = fftshift(repmat(hann(size(Xshifted,1)),1,size(X,2)) .* Xshifted,1);
% %     cInd = floor(size(Xwin,1)/2+1);
% %     C = fft(abs(Xwin));
%     C = fft(A);
%     C(cInd-filLen:cInd+filLen,:) = 0;
%     V = real(ifft(C));
% %     V = V(1:end-sizeOfZeroPadding,:);
% end
%
% A1 = interp1(logAxis,A,linAxis);
%
% filLen = 512 - 15;
%
% A = log(abs(X));
% % A = interp1(linAxis,A,logAxis);
% % A = abs(X);
% V = -Inf(size(X));
% cInd = floor(size(X,1)/2+1);
% for i = 1 : numOfIter
%     A = max(A,V);
%
% %     Xpadded = [A; zeros(sizeOfZeroPadding, size(X,2))];
% %     Xshifted = fftshift(Xpadded,1);
% %     Xwin = fftshift(repmat(hann(size(Xshifted,1)),1,size(X,2)) .* Xshifted,1);
% %     cInd = floor(size(Xwin,1)/2+1);
% %     C = fft(abs(Xwin));
%     C = fft(A);
%     C(cInd-filLen:cInd+filLen,:) = 0;
%     V = real(ifft(C));
% %     V = V(1:end-sizeOfZeroPadding,:);
% end
%
% A2 = A;
%
% A = max(A1,A2);
%
% env = exp(A);
%
% %%

end
