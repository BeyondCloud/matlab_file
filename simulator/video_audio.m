function video_audio(handles)

global pco pco1
global y ym m
global hp

L=str2double(get(handles.L,'string'));
Fs=str2double(get(handles.Fs,'string'));
n=str2double(get(handles.n,'string'));
tm=str2double(get(handles.tm,'string'));
dt=1/Fs;
x=linspace(0,L,n);

y=get(handles.calculate,'UserData');

fsp=str2double(get(handles.fps,'string'));
sc=round((1/fsp)/(1/Fs)); % sound samples per frame = block size

mic1p=get(handles.slider1,'Value');
mic1pL=mic1p*L;
[tmp mic1i]=min(abs(handles.ic.xLine-mic1pL));

mic2p=get(handles.slider2,'Value');
mic2pL=mic2p*L;
[tmp mic2i]=min(abs(handles.ic.xLine-mic2pL));


ym=[y(:,mic1i) y(:,mic2i)]; % sound

m=[mic1i mic2i];



nblocks=4;
margin=nblocks-1;

% audio and video:
hf=figure;
ha=axes;
hp=plot(x,y(1,:),'k.-');
axis manual;
xlim([x(1) x(end)]);
mx=max(abs(y(:)));
if mx==0
    mx=1;
end
ylim([-mx mx]);

drawnow;
pause(0.5);

pso=sc;
ao = analogoutput('winsound');
ch = addchannel(ao,1:2);
%set(ao,'Timeout',3);
set(ao,'SampleRate',Fs);
set(ao,'BufferingConfig',[pso nblocks]);
set(ao,'SamplesOutputFcn',{@add_to_buffer,Fs,ao,pso});
set(ao,'SamplesOutputFcnCount',pso);
d2=zeros(sc,2);
for mc=1:margin % 5 pieces margin
    putdata(ao,d2); % put silence to margin
    pco=mc; % piece counter
end
pco=pco+1;
pco1=1;
start(ao);


wait(ao,tm+0.1);

delete(daqfind);



