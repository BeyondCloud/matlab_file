function video_only(handles)

from=str2double(get(handles.from,'string'));
to=str2double(get(handles.to,'string'));
skf=str2double(get(handles.skf,'string'));
pfr=str2double(get(handles.pfr,'string'));
L=str2double(get(handles.L,'string'));
Fs=str2double(get(handles.Fs,'string'));
n=str2double(get(handles.n,'string'));
dt=1/Fs;
x=linspace(0,L,n);

y=get(handles.calculate,'UserData');
[k n]=size(y);
k1=round(from/dt)+1;
k1=to_limits_2(k1,0,k);
k2=round(to/dt)+1;
k2=to_limits_2(k2,0,k);
hf=figure;
ha=axes;
hp=plot(x,y(1,:),'k.-','parent',ha);
set(ha,'YLimMode','manual');
set(ha,'XLimMode','manual');
mx=1.1*max(y(:));
if mx==0
    mx=1;
end
ylim(ha,[-mx mx]);
xlim(ha,[0 L]);
ht=title(['t=' num2str((k1-1)*dt,'%2.4f') ' s']);
xlabel(ha,'length, m');
ylabel(ha,'amplitude');
for kc=k1:skf:k2
    if ishandle(hp)
        set(hp,'YData',y(kc,:));
        set(ht,'string',['t=' num2str((kc-1)*dt,'%2.4f') ' s'])
        drawnow;
        pause(pfr);
    else
        break;
    end
end
