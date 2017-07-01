function varargout = change_v(varargin)
% CHANGE_V MATLAB code for change_v.fig
%      CHANGE_V, by itself, creates a new CHANGE_V or raises the existing
%      singleton*.
%
%      H = CHANGE_V returns the handle to a new CHANGE_V or the handle to
%      the existing singleton*.
%
%      CHANGE_V('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHANGE_V.M with the given input arguments.
%
%      CHANGE_V('Property','Value',...) creates a new CHANGE_V or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before change_v_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to change_v_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help change_v

% Last Modified by GUIDE v2.5 12-Mar-2012 10:42:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @change_v_OpeningFcn, ...
                   'gui_OutputFcn',  @change_v_OutputFcn, ...
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


% --- Executes just before change_v is made visible.
function change_v_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to change_v (see VARARGIN)

% Choose default command line output for change_v
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes change_v wait for user response (see UIRESUME)
% uiwait(handles.figure1);

xlabel(handles.axes1,'length, m');
ylabel(handles.axes1,'initial velocity, m/s');


ghandles=varargin{1};
velocity=get(ghandles.axes2,'UserData');

y_scale=velocity.y_scale;
set(handles.y_scale,'string',num2str(y_scale));

L=str2double(get(ghandles.L,'string'));
XLim=[0   L];
YLim=[-velocity.y_scale   velocity.y_scale];
xLine=velocity.xi;
vic=interactive_curve(handles.figure1,handles.axes1,velocity.markersX,velocity.markersY,XLim,YLim);
vic.boundary=1;
vic.MarkersInLine=false;
vic.xLine=xLine;
set(vic.lineHandle,'LineStyle','-','Marker','.','Color','b');
xMargin=(XLim(2)-XLim(1))/ghandles.xMarginDivider;
gap=xMargin;
vic.xMargin=xMargin;
vic.gap=gap;
yMargin=y_scale/20;
vic.yMargin=yMargin;

vic.setMarkersColor([0.6 0.8 1]);

vic.motionFunctionHandle=@update_v_graph;
vic.motionFunctionArgument={handles;ghandles;vic};

vic.setMethod(velocity.method);
%vic.redraw();

% set asked method to GUI:
methods=cellstr(get(handles.method,'string'));
for c=1:length(methods)
    if strcmpi(methods{c},velocity.method)
        set(handles.method,'value',c);
        break;
    end
end

handles.vic=vic;
handles.ghandles=ghandles;
% Update handles structure
guidata(hObject, handles);
        






% --- Outputs from this function are returned to the command line.
function varargout = change_v_OutputFcn(hObject, eventdata, handles) 
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

kka=0.6e3; % kick amplitude
switch v
    case 2 % zero
        handles.vic.boundaryYLeft=0;
        handles.vic.boundaryYRight=0;
        
        handles.vic.setMarkersPositions(handles.vic.x,handles.vic.y*0);
    case 3 % kick
        kka=5e3; % kick amplitude
        markersX=L*0.1;
        markersY=kka;
        handles.vic.setMarkersPositions(markersX,markersY);
        handles.vic.setMethod('delta');
        set(handles.method,'value',5);
    case 4 % kicks
        kka=4e3; % kick amplitude
        markersX=[L*0.2 L*0.8];
        markersY=kka*[1 -1];
        handles.vic.setMarkersPositions(markersX,markersY);
        handles.vic.setMethod('delta');
        set(handles.method,'value',5);
     case 5 % triangle
        kka=0.6e3; % kick amplitude
        markersX=L*0.1;
        markersY=kka;
        handles.vic.setMarkersPositions(markersX,markersY);
        handles.vic.setMethod('linear');
        set(handles.method,'value',2);
    case {6,7,8,9,10} % harmonics
        kka=0.5e3; % kick amplitude
        nhr=v-5; % harmonic number
        nod=2*nhr+1; % number of all dots
        if nhr==1
            nod=5;
        end
        XLim=get(handles.vic.axesHandle,'XLim');
        T=XLim(2)-XLim(1);
        %n=5;
        %dx=T/n;
        %markersX=XLim(1)+dx/2:dx:XLim(2)-dx/2;
        markersX1=linspace(XLim(1),XLim(2),2*nod-1);
        markersX=markersX1(2:end-1);
        markersY=kka*sin(2*pi*nhr*markersX/T/2);
        handles.vic.setMarkersPositions(markersX,markersY);
        
        handles.vic.setMethod('spline');
        set(handles.method,'value',3);
        
        
        
end

y_scale=1.1*kka;
velocity=get(handles.ghandles.axes2,'UserData');
velocity.y_scale=y_scale;
set(handles.ghandles.axes2,'UserData',velocity);
set(handles.y_scale,'string',num2str(y_scale));
YLim=[-y_scale  y_scale];
set(handles.axes1,'YLim',YLim);
set(handles.ghandles.axes2,'YLim',YLim);


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
set(handles.ghandles.axes2,'YLim',YLim);
velocity=get(handles.ghandles.axes2,'UserData');
velocity.y_scale=y_scale;
set(handles.ghandles.axes2,'UserData',velocity);
handles.vic.setMarkersPositions(handles.vic.x,handles.vic.y*y_scale/y_scale_old);


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
handles.vic.mouseMode=v;


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
handles.vic.setMethod(method);


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


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
close(handles.figure1);
