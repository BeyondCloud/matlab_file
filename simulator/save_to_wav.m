function save_to_wav(handles)

mic1st=get(handles.mic1,'value');
mic2st=get(handles.mic2,'value');
if mic1st||mic2st
    

    [file,path] = uiputfile('*.wav','Save to wav file');
    if file==0
        return;
    end
    fln=[path file];
    
    
    L=str2double(get(handles.L,'string'));

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

    

    Fs=str2double(get(handles.Fs,'string'));

    

    %y1=[y(:,mic1i) y(:,mic2i)];

    %sound(y1,Fs);

    

    if xor(mic1st,mic2st) 
        % only one graph
        
        
        wavwrite(y11,Fs,fln);
        
            
        
    elseif mic1st&&mic2st
        % both grpah
        y11=y(:,mic1i);
        y12=y(:,mic2i);
        
        wavwrite([y11 y12],Fs,fln);
        
    end
    
end
    
