function varargout = cange_f(varargin)
% CANGE_F MATLAB code for cange_f.fig
%      CANGE_F, by itself, creates a new CANGE_F or raises the existing
%      singleton*.
%
%      H = CANGE_F returns the handle to a new CANGE_F or the handle to
%      the existing singleton*.
%
%      CANGE_F('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CANGE_F.M with the given input arguments.
%
%      CANGE_F('Property','Value',...) creates a new CANGE_F or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cange_f_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cange_f_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cange_f

% Last Modified by GUIDE v2.5 19-Mar-2012 12:13:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cange_f_OpeningFcn, ...
                   'gui_OutputFcn',  @cange_f_OutputFcn, ...
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


% --- Executes just before cange_f is made visible.
function cange_f_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cange_f (see VARARGIN)

% Choose default command line output for cange_f
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Choose default command line output for change_v
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes change_v wait for user response (see UIRESUME)
% uiwait(handles.figure1);

xlabel(handles.axes1,'length, m');
ylabel(handles.axes1,'friction, 1/s');


ghandles=varargin{1};
friction=get(ghandles.axes4,'UserData');

y_scale=friction.y_scale;
set(handles.y_scale,'string',num2str(y_scale));

L=str2double(get(ghandles.L,'string'));
XLim=[0   L];
YLim=[-friction.y_scale   friction.y_scale];
xLine=friction.xi;
fic=interactive_curve(handles.figure1,handles.axes1,friction.markersX,friction.markersY,XLim,YLim);
fic.boundary=1;
fic.boundaryYLeft=friction.boundaryYLeft;
fic.boundaryYRight=friction.boundaryYRight;
fic.MarkersInLine=false;
fic.xLine=xLine;
set(fic.lineHandle,'LineStyle','-','Marker','.','Color','r');
xMargin=(XLim(2)-XLim(1))/ghandles.xMarginDivider;
gap=xMargin;
fic.xMargin=xMargin;
fic.gap=gap;
yMargin=y_scale/20;
fic.yMargin=yMargin;

fic.setMarkersColor([1 0.6 0.6]);

fic.motionFunctionHandle=@update_f_graph;
fic.motionFunctionArgument={handles;ghandles;fic};

fic.setMethod(friction.method);
%fic.redraw();

% set asked method to GUI:
methods=cellstr(get(handles.method,'string'));
for c=1:length(methods)
    if strcmpi(methods{c},friction.method)
        set(handles.method,'value',c);
        break;
    end
end

% set sliders:
set(handles.slider1,'value',fic.boundaryYLeft/y_scale);
set(handles.slider2,'value',fic.boundaryYRight/y_scale);

handles.fic=fic;
handles.ghandles=ghandles;
% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = cange_f_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in pres.
function pres_Callback(hObject, eventdata, handles)
v=get(hObject,'Value');
y_scale=str2double(get(handles.y_scale,'String')); 
L=str2double(get(handles.ghandles.L,'String'));
switch v
    case 2 % zero
        handles.fic.boundaryYLeft=0;
        handles.fic.boundaryYRight=0;
        
        handles.fic.setMarkersPositions(handles.fic.x,handles.fic.y*0);
        
    case 3 % ends
        a=y_scale/1.1;
        aa=a/4;
        markersX1=linspace(0,L,10);
        markersX=markersX1(2:end-1);
        markersY=zeros(size(markersX));
        markersY(1)=aa;
        markersY(end)=aa;
        
        handles.fic.boundaryYLeft=a;
        handles.fic.boundaryYRight=a;
        handles.fic.setMarkersPositions(markersX,markersY);
        handles.fic.setMethod('pchip');
        set(handles.method,'value',4);
        
    case 4 % uniform
        a=y_scale/1.5;
        aa=a/1;
        markersX1=linspace(0,L,10);
        markersX=markersX1(2:end-1);
        %markersY=zeros(size(markersX));
        %markersY(1)=aa;
        %markersY(end)=aa;
        markersY=aa*ones(size(markersX));
        
        handles.fic.boundaryYLeft=a;
        handles.fic.boundaryYRight=a;
        handles.fic.setMarkersPositions(markersX,markersY);
        handles.fic.setMethod('pchip');
        set(handles.method,'value',4);
        
    case 5 % mixed
        
        a=y_scale/1.1;
        aa=a/4;
        markersX1=linspace(0,L,10);
        markersX=markersX1(2:end-1);
        %markersY=zeros(size(markersX));
        %markersY(1)=aa;
        %markersY(end)=aa;
        markersY=aa*ones(size(markersX));
        
        handles.fic.boundaryYLeft=a;
        handles.fic.boundaryYRight=a;
        handles.fic.setMarkersPositions(markersX,markersY);
        handles.fic.setMethod('pchip');
        set(handles.method,'value',4);
        
    case 6 % left
        a=y_scale/1.1;
        aa=a/4;
        markersX1=linspace(0,L,10);
        markersX=markersX1(2:end-1);
        markersY=zeros(size(markersX));
        markersY(1)=aa;
        %markersY(end)=aa;
        markersY(end)=0;
        
        
        handles.fic.boundaryYLeft=a;
        %handles.fic.boundaryYRight=a;
        handles.fic.boundaryYRight=0;
        handles.fic.setMarkersPositions(markersX,markersY);
        handles.fic.setMethod('pchip');
        set(handles.method,'value',4);
        
    case 7 % right
        a=y_scale/1.1;
        aa=a/4;
        markersX1=linspace(0,L,10);
        markersX=markersX1(2:end-1);
        markersY=zeros(size(markersX));
        %markersY(1)=aa;
        markersY(end)=aa;
        markersY(1)=0;
        
        
        %handles.fic.boundaryYLeft=a;
        handles.fic.boundaryYRight=a;
        handles.fic.boundaryYLeft=0;
        handles.fic.setMarkersPositions(markersX,markersY);
        handles.fic.setMethod('pchip');
        set(handles.method,'value',4);
        
        
end

set(handles.slider1,'value',handles.fic.boundaryYLeft/y_scale);
set(handles.slider2,'value',handles.fic.boundaryYRight/y_scale);


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



function y_scale_Callback(hObject, eventdata, handles)
y_scale=str2double(get(hObject,'String')); 
YLim_old=get(handles.axes1,'YLim');
y_scale_old=YLim_old(2);
YLim=[-y_scale  y_scale];
set(handles.axes1,'YLim',YLim);
set(handles.ghandles.axes4,'YLim',YLim);
friction=get(handles.ghandles.axes4,'UserData');
friction.y_scale=y_scale;
friction.boundaryYLeft=friction.boundaryYLeft*y_scale/y_scale_old;
friction.boundaryYRight=friction.boundaryYRight*y_scale/y_scale_old;
handles.fic.boundaryYLeft=friction.boundaryYLeft;
handles.fic.boundaryYRight=friction.boundaryYRight;
set(handles.ghandles.axes4,'UserData',friction);
handles.fic.setMarkersPositions(handles.fic.x,handles.fic.y*y_scale/y_scale_old);


% --- Executes during object creation, after setting all properties.
function y_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mmode.
function mmode_Callback(hObject, eventdata, handles)
v=get(hObject,'Value');
handles.fic.mouseMode=v;


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
handles.fic.setMethod(method);


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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
close(handles.figure1);


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
friction=get(handles.ghandles.axes4,'UserData');
fic=handles.fic;
v=get(hObject,'Value');
YLim=get(handles.axes1,'YLim');
y_scale=YLim(2);
fic.boundaryYLeft=v*y_scale;
friction.boundaryYLeft=fic.boundaryYLeft;
set(handles.ghandles.axes4,'UserData',friction);
fic.redraw();


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
friction=get(handles.ghandles.axes4,'UserData');
fic=handles.fic;
v=get(hObject,'Value');
YLim=get(handles.axes1,'YLim');
y_scale=YLim(2);
fic.boundaryYRight=v*y_scale;
friction.boundaryYRight=fic.boundaryYRight;
set(handles.ghandles.axes4,'UserData',friction);
fic.redraw();


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
