function calculate(handles)

hwb = waitbar(0,'calulate... 0 %');
drawnow;

T=str2double(get(handles.T,'string'));
mu=str2double(get(handles.mu,'string'));
L=str2double(get(handles.L,'string'));
Fs=str2double(get(handles.Fs,'string'));
n=str2double(get(handles.n,'string'));
tm=str2double(get(handles.tm,'string'));
dx=L/(n-1);

dt=1/Fs;
cc=dt^2*T/(mu*dx^2);


v2=T/mu;
v2i=1/v2;



t=0:dt:tm;
k=length(t);


y=zeros(k,n);

% initial condition:
get(handles.ic.lineHandle,'YData');
y(1,:)=get(handles.ic.lineHandle,'YData');
velocity=get(handles.axes2,'UserData');
vy=get(velocity.hp,'YData');
y(2,:)=y(1,:)+vy*dt; % starts from rest


cr=[1  -2  1];

% friction:
friction=get(handles.axes4,'UserData');
fy=get(friction.hp,'YData');



tic;
toc0=toc;
for tc=2:k-1
    y(tc+1,:)=(2-dt*fy).*y(tc,:)-(1-dt*fy).*y(tc-1,:)+cc*conv(y(tc,:),cr,'same');
    
    % boundary condition:
    y(tc+1,1)=0;
    y(tc+1,end)=0;
    

    if ((toc-toc0)>0.2)
        toc0=toc;
        jr=tc/k;
        waitbar(jr,hwb,['calulate... ' num2str(jr*100,'%2.1f') ' %']);
        drawnow;
    end
end
delete(hwb);

set(handles.calculate,'UserData',y); % momorize result



handles.calculated_flag=true;
update_calulated(handles);