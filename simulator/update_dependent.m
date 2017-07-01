function update_dependent(handles)
% update dependent edit filds: fundamental frequency, dt, cc

T=str2double(get(handles.T,'string'));
mu=str2double(get(handles.mu,'string'));
L=str2double(get(handles.L,'string'));
Fs=str2double(get(handles.Fs,'string'));
n=str2double(get(handles.n,'string'));
dx=L/(n-1);

f=sqrt(T/mu)/(2*L);
set(handles.f,'string',num2str(f));

dt=1/Fs;
set(handles.dt,'string',num2str(dt,'%10.2e'));

cc=dt^2*T/(mu*dx^2);
set(handles.cc,'string',num2str(cc));
if cc>1
    set(handles.m1,'visible','on');
    set(handles.unstable,'visible','on');
else
    set(handles.m1,'visible','off');
    set(handles.unstable,'visible','off');
end
