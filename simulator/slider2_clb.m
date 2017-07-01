function slider2_clb(handles)
mic2p=get(handles.slider2,'Value');
L=str2double(get(handles.L,'string'));
mic2pL=mic2p*L;
[tmp mic2i]=min(abs(handles.ic.xLine-mic2pL));
handles.mic2i=mic2i;
YLim=get(handles.axes1,'YLim');
set(handles.m2hp,'XData',[handles.ic.xLine(mic2i) handles.ic.xLine(mic2i)],'YData',[YLim(1) YLim(2)]);