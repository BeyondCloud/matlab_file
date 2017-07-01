function audio_only(handles)


L=str2double(get(handles.L,'string'));

mic1p=get(handles.slider1,'Value');
mic1pL=mic1p*L;
[tmp mic1i]=min(abs(handles.ic.xLine-mic1pL));

mic2p=get(handles.slider2,'Value');
mic2pL=mic2p*L;
[tmp mic2i]=min(abs(handles.ic.xLine-mic2pL));

Fs=str2double(get(handles.Fs,'string'));

y=get(handles.calculate,'UserData');

y1=[y(:,mic1i) y(:,mic2i)];

sound(y1,Fs);
