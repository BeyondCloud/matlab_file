function spectrogram_speech_file(x,iwb_nb,fs,dyn_range,graphicPanel)
%
% spectrogram function

% Inputs:
%   x: speech signal for spectrogram
%   iwb_nb: switch for wideband or narrowband spectrogram
%   fs: speech sampling rate
%   graphicPanel: panel in which to plot spectrogram

% spectrogram parameters
    winlen_WB=4;
    winlen_NB=40;
    nfft_WB=1024;
    nfft_NB=1024;
    overlap=95;
    map_index=2;
    select_win=1;
    logLinear_index=1;
    
% converting window lengths from ms to samples
    winlen_WBsamples = fix(winlen_WB*0.001*fs); 
    winlen_NBsamples = fix(winlen_NB*0.001*fs);
% overlap in samples based on window size
	overlap_WB=fix(overlap*winlen_WBsamples/100);
    overlap_NB=fix(overlap*winlen_NBsamples/100);
% selection of window
	w_WB = window(@hamming,winlen_WBsamples);
    w_NB = window(@hamming,winlen_NBsamples);
    
% gray scale map
	t=colormap(gray);
	colormap(1-t);

% set up either wideband (iwb_nb = 1) or narrowband (iwb_nb=2) spectrogram
    if (iwb_nb == 1)
% create and plot wideband spectrogram on graphicsPanel
        [B,BA,F,T]=create_spectrogram(x,nfft_WB,fs,w_WB,dyn_range,logLinear_index,overlap_WB);
        reset(graphicPanel);
        axes(graphicPanel);
        imagesc(T,F,BA);
        
        xpp=['Wideband Spectrogram: Time in Seconds; fs=',num2str(fs),' samples/second'];
        axis xy,xlabel(xpp),ylabel('Frequency in Hz');
        axis([0 length(x)/fs 0 fs/2]);
        axis tight;
        
    elseif (iwb_nb == 2)        
% create and plot narrowband spectrogram on graphicsPanel
        [B,BA,F,T]=create_spectrogram(z3n,nfft_NB,fs,w_NB,dyn_range,logLinear_index,overlap_NB);
        reset(graphicPanel);
        axes(graphicPanel);
        imagesc(T,F,BA);
        
        xpp=['Narrowband Spectrogram: Time in Seconds; fs=',num2str(fs),' samples/second'];
        axis xy,xlabel(xpp),ylabel('Frequency in Hz');
        axis([0 length(x)/fs 0 fs/2]);
        axis tight;
    end
end