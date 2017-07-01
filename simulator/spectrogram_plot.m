function spectrogram_plot(handles)

mic1st=get(handles.mic1,'value');
mic2st=get(handles.mic2,'value');
window=1024;
noverlap=window/2;
if mic1st||mic2st
    L=str2double(get(handles.L,'string'));
    T=str2double(get(handles.T,'string'));
    mu=str2double(get(handles.mu,'string'));
    f=sqrt(T/mu)/(2*L); % fundamental frequency
   
    mic1p=get(handles.slider1,'Value');
    mic1pL=mic1p*L;
    [tmp mic1i]=min(abs(handles.ic.xLine-mic1pL));
    mic2p=get(handles.slider2,'Value');
    mic2pL=mic2p*L;
    [tmp mic2i]=min(abs(handles.ic.xLine-mic2pL));
    
    y=get(handles.calculate,'UserData');
    if mic1st
        y11=y(:,mic1i);
    else
        y11=y(:,mic2i);
    end
    
    if length(y11)<=1
        return;
    end

    

    Fs=str2double(get(handles.Fs,'string'));
    dt=1/Fs;
    %y1=[y(:,mic1i) y(:,mic2i)];
    %sound(y1,Fs);
    if xor(mic1st,mic2st) 
        % only one graph        
        hf=figure;
        ha=axes;
        F1=0:f/5:10*f;
        [S,F2,T,P]=spectrogram(y11,window,noverlap,F1,Fs);
        t=(0:length(y11)-1)*dt;
        imagesc(T,F2,10*log10(P));
        colorbar;
        xlabel(ha,'time, s');
        ylabel(ha,'spectrum, Hz');
        title('Power, db');
    elseif mic1st&&mic2st
        % both grpah
        y11=y(:,mic1i);
        y12=y(:,mic2i);
        hf=figure;
        ha=subplot(2,1,1);
        F1=0:f/5:10*f;
        [S,F2,T,P]=spectrogram(y11,window,noverlap,F1,Fs);
        imagesc(T,F2,10*log10(P));
        colorbar;
        xlabel(ha,'time, s');
        ylabel(ha,'spectrum, Hz');
        title('Power, db');
        ha=subplot(2,1,2);
        F1=0:f/5:10*f;
        [S,F2,T,P]=spectrogram(y12,window,noverlap,F1,Fs);
        imagesc(T,F2,10*log10(P));
        colorbar;
        xlabel(ha,'time, s');
        ylabel(ha,'spectrum, Hz');
        title('Power, db');
    end
end
    
