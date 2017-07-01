function graph(handles)

mic1st=get(handles.mic1,'value');
mic2st=get(handles.mic2,'value');
if mic1st||mic2st
    
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
        cl='m-';
    else
        y11=y(:,mic2i);
        cl='c-';
    end

    

    Fs=str2double(get(handles.Fs,'string'));
    dt=1/Fs;

    

    %y1=[y(:,mic1i) y(:,mic2i)];

    %sound(y1,Fs);

    

    if xor(mic1st,mic2st) 
        % only one graph
        
        hf=figure;
        ha=axes;
        t=(0:length(y11)-1)*dt;
        hp=plot(t,y11,cl,'parent',ha);
        set(ha,'YLimMode','manual');
        set(ha,'XLimMode','manual');
        mx=1.2*max(y11);
        if mx==0
            mx=1;
        end
        ylim(ha,[-mx mx]);
        if t(1)==t(end)
            xlim(ha,[t(1) t(1)+1]);
        else
            xlim(ha,[t(1) t(end)]);
        end
        xlabel(ha,'time, s');
        ylabel(ha,'amplitude');
            
        
    elseif mic1st&&mic2st
        % both grpah
        hf=figure;
        ha=axes;
        y11=y(:,mic1i);
        cl1='m-';
        y12=y(:,mic2i);
        cl2='c-';
        t=(0:length(y11)-1)*dt;
        hp=plot(t,y11,cl1,'parent',ha);
        hold on;
        hp=plot(t,y12,cl2,'parent',ha);
        hp=plot(t,y11,cl1,'parent',ha);
        set(ha,'YLimMode','manual');
        set(ha,'XLimMode','manual');
        mx=1.1*max(y11);
        if mx==0
            mx=1;
        end
        ylim(ha,[-mx mx]);
        if t(1)==t(end)
            xlim(ha,[t(1) t(1)+1]);
        else
            xlim(ha,[t(1) t(end)]);
        end
        
    end
    
end
    
