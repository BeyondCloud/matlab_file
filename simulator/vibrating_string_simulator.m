function vibrating_string_simulator(varargin)
% VIBRATING_STRING_SIMULATOR MATLAB code for vibrating_string_simulator.fig
%      VIBRATING_STRING_SIMULATOR, by itself, creates a new VIBRATING_STRING_SIMULATOR or raises the existing
%      singleton*.
%
%      H = VIBRATING_STRING_SIMULATOR returns the handle to a new VIBRATING_STRING_SIMULATOR or the handle to
%      the existing singleton*.
%
%      VIBRATING_STRING_SIMULATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATING_STRING_SIMULATOR.M with the given input arguments.
%
%      VIBRATING_STRING_SIMULATOR('Property','Value',...) creates a new VIBRATING_STRING_SIMULATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrating_string_simulator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrating_string_simulator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrating_string_simulator

% Last Modified by GUIDE v2.5 20-Mar-2012 12:01:44

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1; % exe program won't create two window  

gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrating_string_simulator_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrating_string_simulator_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before vibrating_string_simulator is made visible.
function vibrating_string_simulator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrating_string_simulator (see VARARGIN)

% Choose default command line output for vibrating_string_simulator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrating_string_simulator wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% axis(handles.axes2,'off');
% axis(handles.axes4,'off');


% initial values:
L=0.63; % m, length of string
n=30; % number of nodes
T=220; % N, tension
mu=0.02; % kg/m string mass
tm=7.5; % s, simulation time
Fs=22050; % Hz, sampling frequency
calculated_flag=false; % not calulated at the begining

% only video display initial values:
from=0;
to=0.1;
skf=4; % skeep frames
pfr=0.02; % pause frame

xMarginDivider=70;
yMargin=0.05;

XLim=[0 L];
YLim=[-1 1];
xLine=linspace(0,L,n);

mic1p=0.3;
mic2p=0.6; % microphones positions

fps=23; % frames per second for video+audio visualization

mic1st=true;
mic2st=false;

set(handles.L,'string',num2str(L));
set(handles.n,'string',num2str(n));
set(handles.T,'string',num2str(T));
set(handles.mu,'string',num2str(mu));
set(handles.tm,'string',num2str(tm));
set(handles.Fs,'string',num2str(Fs));

set(handles.from,'string',num2str(from));
set(handles.to,'string',num2str(to));
set(handles.skf,'string',num2str(skf));
set(handles.pfr,'string',num2str(pfr));

set(handles.fps,'string',num2str(fps));


set(handles.slider1,'value',mic1p);
set(handles.slider2,'value',mic2p);

set(handles.mic1,'value',mic1st);
set(handles.mic2,'value',mic2st);

% draw mcrophones lines:
set(handles.axes1,'NextPlot','add');
mic1pL=mic1p*L;
mic2pL=mic2p*L;
[tmp mic1i]=min(abs(xLine-mic1pL));
handles.mic1i=mic1i;
[tmp mic2i]=min(abs(xLine-mic2pL));
handles.mic2i=mic2i;
m1hp=plot([xLine(mic1i) xLine(mic1i)],[YLim(1) YLim(2)],'m--','parent',handles.axes1);
handles.m1hp=m1hp;
m2hp=plot([xLine(mic2i) xLine(mic2i)],[YLim(1) YLim(2)],'c--','parent',handles.axes1);
handles.m2hp=m2hp;

axis(handles.axes1,'manual');
%ylim(handles.axes1,[-1 1]);

markersX=L*0.1;
markersY=0.8;
ic=interactive_curve(handles.figure1,handles.axes1,markersX,markersY,XLim,YLim);
ic.boundary=1;
ic.xLine=xLine;
set(ic.lineHandle,'LineStyle','-','Marker','.');
xMargin=(XLim(2)-XLim(1))/xMarginDivider;
gap=xMargin;
ic.xMargin=xMargin;
ic.gap=gap;
ic.yMargin=yMargin;





handles.calculated_flag=calculated_flag;
% if any motion then set "not calulated" state:
ic.motionFunctionHandle=@set_calc_false;
ic.motionFunctionArgument=handles;

ic.MarkersInLine=false;

ic.redraw();



handles.ic=ic;


handles.xMarginDivider=xMarginDivider;

% Update handles structure
guidata(hObject, handles);

update_dependent(handles);

update_calulated(handles);


% velocity structure
velocity=struct;
velocity.markersX=markersX;
velocity.markersY=zeros(size(markersX));
velocity.method='delta';
%velocity.y_scale=1;

% plot:
xi=xLine;
yi=interp1_v(velocity.markersX,velocity.markersY,xi,velocity.method,L);
velocity.xi=xi;
velocity.yi=yi;
velocity.hp=plot(xi,yi,'b.-','parent',handles.axes2);
axis(handles.axes2,'manual');
xlim(handles.axes2,[0 L]);
mx=1.1*max(abs(velocity.markersY));
if mx==0
    mx=1;
end
velocity.y_scale=mx;
ylim(handles.axes2,[-mx mx]);
set(handles.axes2,'UserData',velocity);



% friction structure
friction=struct;
a=10/1.1;
aa=a/4;
friction.boundaryYLeft=a;
friction.boundaryYRight=a;
markersX1=linspace(0,L,10);
markersX=markersX1(2:end-1);
friction.markersX=markersX;
markersY=zeros(size(markersX));
markersY(1)=aa;
markersY(end)=aa;
friction.markersY=markersY;
friction.method='pchip';
%friction.y_scale=1;

% plot:

xi=xLine;
yi=interp1_f(friction.markersX,friction.markersY,xi,friction.method,L,friction.boundaryYLeft,friction.boundaryYRight);
friction.xi=xi;
friction.yi=yi;
friction.hp=plot(xi,yi,'r.-','parent',handles.axes4);
axis(handles.axes4,'manual');
xlim(handles.axes4,[0 L]);
mx=1.1*max(abs([friction.markersY   friction.boundaryYLeft     friction.boundaryYRight ]));
if mx==0
    mx=1;
end
friction.y_scale=mx;
ylim(handles.axes4,[-mx mx]);
set(handles.axes4,'UserData',friction);

y=zeros(1,n); % one step zeros for solution for initial not calulated state
set(handles.calculate,'UserData',y);

% --- Outputs from this function are returned to the command line.
function varargout = vibrating_string_simulator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in gpres.
function gpres_Callback(hObject, eventdata, handles)
global_preset(handles);


% --- Executes during object creation, after setting all properties.
function gpres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gpres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function L_Callback(hObject, eventdata, handles)
handles.calculated_flag=false;
update_calulated(handles);

XLim=get(handles.ic.axesHandle,'XLim');
L_old=XLim(2)-XLim(1);
L=str2double(get(handles.L,'String'));
handles.ic.setXLim([0 L]);

n=str2double(get(handles.n,'String'));
xLine=linspace(0,L,n);


handles.ic.setMarkersPositions(handles.ic.x*L/L_old,handles.ic.y);


xMargin=L/handles.xMarginDivider;
handles.ic.xMargin=xMargin;
handles.ic.gap=xMargin;



handles.ic.xLine=xLine;
handles.ic.redraw();


update_dependent(handles);
slider1_clb(handles);
slider2_clb(handles);



velocity=get(handles.axes2,'UserData');

velocity.markersX=(L/L_old)*velocity.markersX;

% update graph:
xLine=linspace(0,L,n);
xi=xLine;
%yi=interp1_v(velocity.markersX,velocity.markersY,xi,velocity.method,L);
velocity.xi=xi;
%velocity.yi=yi;
%set(velocity.hp,'XData',xi,'YData',yi);
set(velocity.hp,'XData',xi);
xlim(handles.axes2,[0 L]);
% mx=1.1*max(abs(velocity.markersY));
% if mx==0
%     mx=1;
% end
% velocity.y_scale=mx;
% ylim(handles.axes2,[-mx mx]);
set(handles.axes2,'UserData',velocity);


% update friction:
friction=get(handles.axes4,'UserData');
friction.markersX=(L/L_old)*friction.markersX;
% update graph:
xLine=linspace(0,L,n);
xi=xLine;
friction.xi=xi;
set(friction.hp,'XData',xi);
xlim(handles.axes4,[0 L]);
set(handles.axes4,'UserData',friction);


% --- Executes during object creation, after setting all properties.
function L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mu_Callback(hObject, eventdata, handles)
handles.calculated_flag=false;
update_calulated(handles);

update_dependent(handles);


% --- Executes during object creation, after setting all properties.
function mu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tm_Callback(hObject, eventdata, handles)
handles.calculated_flag=false;
update_calulated(handles);

update_dependent(handles);


% --- Executes during object creation, after setting all properties.
function tm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Fs_Callback(hObject, eventdata, handles)
handles.calculated_flag=false;
update_calulated(handles);

update_dependent(handles);


% --- Executes during object creation, after setting all properties.
function Fs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dt_Callback(hObject, eventdata, handles)
% hObject    handle to dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dt as text
%        str2double(get(hObject,'String')) returns contents of dt as a double


% --- Executes during object creation, after setting all properties.
function dt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in change_v.
function change_v_Callback(hObject, eventdata, handles)
handles.calculated_flag=false;
update_calulated(handles);
change_v(handles);


% --- Executes on button press in change_al.
function change_al_Callback(hObject, eventdata, handles)
handles.calculated_flag=false;
update_calulated(handles);
cange_f(handles);


% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)

calculate(handles);






function fps_Callback(hObject, eventdata, handles)
% hObject    handle to fps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fps as text
%        str2double(get(hObject,'String')) returns contents of fps as a double


% --- Executes during object creation, after setting all properties.
function fps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in av.
function av_Callback(hObject, eventdata, handles)
video_audio(handles);



function from_Callback(hObject, eventdata, handles)
% hObject    handle to from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of from as text
%        str2double(get(hObject,'String')) returns contents of from as a double


% --- Executes during object creation, after setting all properties.
function from_CreateFcn(hObject, eventdata, handles)
% hObject    handle to from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function to_Callback(hObject, eventdata, handles)
% hObject    handle to to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of to as text
%        str2double(get(hObject,'String')) returns contents of to as a double


% --- Executes during object creation, after setting all properties.
function to_CreateFcn(hObject, eventdata, handles)
% hObject    handle to to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function skf_Callback(hObject, eventdata, handles)
% hObject    handle to skf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of skf as text
%        str2double(get(hObject,'String')) returns contents of skf as a double


% --- Executes during object creation, after setting all properties.
function skf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to skf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pfr_Callback(hObject, eventdata, handles)
% hObject    handle to pfr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pfr as text
%        str2double(get(hObject,'String')) returns contents of pfr as a double


% --- Executes during object creation, after setting all properties.
function pfr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pfr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in video.
function video_Callback(hObject, eventdata, handles)
video_only(handles);


% --- Executes on button press in audio.
function audio_Callback(hObject, eventdata, handles)
audio_only(handles);


% --- Executes on button press in mic1.
function mic1_Callback(hObject, eventdata, handles)
% hObject    handle to mic1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mic1


% --- Executes on button press in mic2.
function mic2_Callback(hObject, eventdata, handles)
% hObject    handle to mic2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mic2


% --- Executes on button press in graph.
function graph_Callback(hObject, eventdata, handles)
graph(handles);


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
slider1_clb(handles);



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
slider2_clb(handles);


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function cc_Callback(hObject, eventdata, handles)
% hObject    handle to cc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cc as text
%        str2double(get(hObject,'String')) returns contents of cc as a double


% --- Executes during object creation, after setting all properties.
function cc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function f_Callback(hObject, eventdata, handles)
% hObject    handle to f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f as text
%        str2double(get(hObject,'String')) returns contents of f as a double


% --- Executes during object creation, after setting all properties.
function f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pres.
function pres_Callback(hObject, eventdata, handles)
v=get(hObject,'Value');
switch v
    case 2 % zero
        handles.ic.boundaryYLeft=0;
        handles.ic.boundaryYRight=0;
        
        handles.ic.setMarkersPositions(handles.ic.x,handles.ic.y*0);
        
   
     case 3 % triangle
        L=str2double(get(handles.L,'String'));
        markersX=L*0.1;
        markersY=0.8;
        handles.ic.setMarkersPositions(markersX,markersY);
        handles.ic.setMethod('linear');
        set(handles.method,'value',2);
    case {4,5,6,7,8} % harmonics
        nhr=v-3; % harmonic number
        nod=2*nhr+1; % number of all dots
        if nhr==1
            nod=5;
        end
        XLim=get(handles.ic.axesHandle,'XLim');
        T=XLim(2)-XLim(1);
        %n=5;
        %dx=T/n;
        %markersX=XLim(1)+dx/2:dx:XLim(2)-dx/2;
        markersX1=linspace(XLim(1),XLim(2),2*nod-1);
        markersX=markersX1(2:end-1);
        markersY=0.9*sin(2*pi*nhr*markersX/T/2);
        handles.ic.setMarkersPositions(markersX,markersY);
        
        handles.ic.setMethod('spline');
        set(handles.method,'value',3);
        
end


% --- Executes during object creation, after setting all properties.
function pres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mmode.
function mmode_Callback(hObject, eventdata, handles)
v=get(hObject,'Value');
handles.ic.mouseMode=v;


% --- Executes during object creation, after setting all properties.
function mmode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mmode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in method.
function method_Callback(hObject, eventdata, handles)
v=get(hObject,'Value');
contents = cellstr(get(hObject,'String'));
method = contents{v};
handles.ic.setMethod(method);


% --- Executes during object creation, after setting all properties.
function method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in wav.
function wav_Callback(hObject, eventdata, handles)
save_to_wav(handles);



function n_Callback(hObject, eventdata, handles)
handles.calculated_flag=false;
update_calulated(handles);

L=str2double(get(handles.L,'String'));
n=str2double(get(handles.n,'String'));
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
% ylim(handles.axes2,[-mx mx]);
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
set(handles.axes4,'UserData',friction);


% --- Executes during object creation, after setting all properties.
function n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T_Callback(hObject, eventdata, handles)
handles.calculated_flag=false;
update_calulated(handles);

update_dependent(handles);


% --- Executes on button press in spectrogram.
function spectrogram_Callback(hObject, eventdata, handles)
spectrogram_plot(handles);


% --- Executes on button press in save_data.
function save_data_Callback(hObject, eventdata, handles)
save_data(handles);
