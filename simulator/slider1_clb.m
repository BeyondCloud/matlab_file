function slider1_clb(handles)
mic1p=get(handles.slider1,'Value');
L=str2double(get(handles.L,'string'));
mic1pL=mic1p*L;
[tmp mic1i]=min(abs(handles.ic.xLine-mic1pL));
handles.mic1i=mic1i;
YLim=get(handles.axes1,'YLim');
set(handles.m1hp,'XData',[handles.ic.xLine(mic1i) handles.ic.xLine(mic1i)],'YData',[YLim(1) YLim(2)]);