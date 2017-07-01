function global_preset(handles)
v=get(handles.gpres,'value');

tm=7.5;

gsh=1; % guitar optins shift
switch v
    case {2,3,4,5,6,7} % guitar string
        gsn=v-gsh; % guitar string number
        L=0.63;
        %E - 82.4  440*2^((-29)/12)
        %A - 110   440*2^(-24/12)
        %D - 146.8  440*2^((-19)/12)
        %G - 196   440*2^((-14)/12)
        %B - 246.9  440*2^((-10)/12)
        %E - 329.6   440*2^((-5)/12)
        htv=[-5   -10   -14   -19   -24   -29]; % half tones vector
        ff=440*2.^(htv/12);
        
        mus=linspace(0.003,0.02,6);
        TT=mus.*(ff.*2.*L).^2;
        
        mu=mus(gsn);
        T=TT(gsn);
        n=30;
        Fs=22050;
        
        % % zero velocity:
        %velocity=get(handles.axes2,'UserData');
        %velocity.markersY=0*velocity.markersY;
        %set(handles.axes2,'UserData',velocity);
        
        % friction on the ends:
        friction=get(handles.axes4,'UserData');
        friction.y_scale=20;
        a=friction.y_scale/1.1;
        aa=a/4;
        aaa=a/15;
        markersX1=linspace(0,L,10);
        markersX=markersX1(2:end-1);
        markersY=zeros(size(markersX));
        markersY=aaa*ones(size(markersX));
        markersY(1)=aa;
        markersY(end)=aa;
        friction.markersX=markersX;
        friction.markersY=markersY;
        
        friction.boundaryYLeft=a;
        friction.boundaryYRight=a;
        
        friction.method='pchip';
        
        set(handles.axes4,'UserData',friction);
        
        
    case 8 % drum
        
        mu=0.02;
        T=30;
        n=5;
        Fs=22050;
        L=0.63;
        tm=1.5;
        
        % friction on the ends:
        friction=get(handles.axes4,'UserData');
        friction.y_scale=150;
        a=friction.y_scale/1.1;
        aa=a/4;
        aaa=a/15;
        markersX1=linspace(0,L,10);
        markersX=markersX1(2:end-1);
        markersY=zeros(size(markersX));
        markersY=aaa*ones(size(markersX));
        markersY(1)=aa;
        markersY(end)=aa;
        friction.markersX=markersX;
        friction.markersY=markersY;
        
        friction.boundaryYLeft=a;
        friction.boundaryYRight=a;
        
        friction.method='pchip';
        
        set(handles.axes4,'UserData',friction);
        
        
        
        % velocity:
        velocity=get(handles.axes2,'UserData');
        velocity.y_scale=500;
        a=velocity.y_scale/1.1;
        aaa=a;
        markersX1=linspace(0,L,5);
        markersX=markersX1(2);
        markersY=zeros(size(markersX));
        markersY=aaa*ones(size(markersX));
        velocity.markersX=markersX;
        velocity.markersY=markersY;
        
        velocity.method='linear';
        
        set(handles.axes2,'UserData',velocity);
        
        handles.ic.boundaryYLeft=0;
        handles.ic.boundaryYRight=0;
        
        handles.ic.setMarkersPositions(handles.ic.x,handles.ic.y*0);
        
    case 9 % echo
        
        mu=0.02;
        T=1;
        n=300;
        Fs=22050;
        L=0.63;
        tm=5;
        
        % friction on the ends:
        friction=get(handles.axes4,'UserData');
        friction.y_scale=20;
        a=friction.y_scale/1.1;
        aa=a/4;
        aaa=a/15;
        markersX1=linspace(0,L,10);
        markersX=markersX1(2:end-1);
        markersY=zeros(size(markersX));
        markersY=aaa*ones(size(markersX));
        markersY(1)=aa;
        markersY(end)=aa;
        friction.markersX=markersX;
        friction.markersY=markersY;
        
        friction.boundaryYLeft=a;
        friction.boundaryYRight=a;
        
        friction.method='pchip';
        
        set(handles.axes4,'UserData',friction);
        
        
        
        % velocity:
        velocity=get(handles.axes2,'UserData');
        velocity.y_scale=5000;
        a=velocity.y_scale/1.1;
        aaa=a;
        markersX1=linspace(0,L,5);
        markersX=markersX1(2);
        markersY=zeros(size(markersX));
        markersY=aaa*ones(size(markersX));
        velocity.markersX=markersX;
        velocity.markersY=markersY;
        
        velocity.method='delta';
        
        set(handles.axes2,'UserData',velocity);
        
        handles.ic.boundaryYLeft=0;
        handles.ic.boundaryYRight=0;
        
        handles.ic.setMarkersPositions(handles.ic.x,handles.ic.y*0);
        
        
        
        
        
        
end

handles.calculated_flag=false;
set(handles.L,'string',num2str(L));
set(handles.n,'string',num2str(n));
set(handles.T,'string',num2str(T));
set(handles.mu,'string',num2str(mu));
set(handles.Fs,'string',num2str(Fs));

set(handles.tm,'string',num2str(tm));


xLine=linspace(0,L,n);
handles.ic.xLine=xLine;
handles.ic.redraw();

update_dependent(handles);
slider1_clb(handles);
slider2_clb(handles);


velocity=get(handles.axes2,'UserData');


% update graph:
xLine=linspace(0,L,n);
xi=xLine;
yi=interp1_v(velocity.markersX,velocity.markersY,xi,velocity.method,L);
velocity.xi=xi;
velocity.yi=yi;
set(velocity.hp,'XData',xi,'YData',yi);
%xlim(handles.axes2,[0 L]);
% mx=1.1*max(abs(velocity.markersY));
% if mx==0
%     mx=1;
% end
% velocity.y_scale=mx;
mx=velocity.y_scale;
ylim(handles.axes2,[-mx mx]);
set(handles.axes2,'UserData',velocity);


% update friction:
friction=get(handles.axes4,'UserData');
% update graph:
xLine=linspace(0,L,n);
xi=xLine;
yi=interp1_f(friction.markersX,friction.markersY,xi,friction.method,L,friction.boundaryYLeft,friction.boundaryYRight);
friction.xi=xi;
friction.yi=yi;
set(friction.hp,'XData',xi,'YData',yi);
mx=1.1*max(abs([friction.markersY friction.boundaryYLeft  friction.boundaryYRight ]));
if mx==0
    mx=1;
end
friction.y_scale=mx;
ylim(handles.axes4,[-mx mx]);
set(handles.axes4,'UserData',friction);