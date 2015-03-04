function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 21-Nov-2012 15:25:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

figure1_ResizeFcn(hObject, eventdata, handles)


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buttonUp.
function buttonUp_Callback(hObject, eventdata, handles)
% hObject    handle to buttonUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
deplaceRobot('up')

% --- Executes on button press in buttonDown.
function buttonDown_Callback(hObject, eventdata, handles)
% hObject    handle to buttonDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
deplaceRobot('down')

% --- Executes on button press in buttonRight.
function buttonRight_Callback(hObject, eventdata, handles)
% hObject    handle to buttonRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
deplaceRobot('right')

% --- Executes on button press in buttonLeft.
function buttonLeft_Callback(hObject, eventdata, handles)
% hObject    handle to buttonLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
deplaceRobot('left')

% --- Executes on button press in buttonTakeScan.
function buttonTakeScan_Callback(hObject, eventdata, handles)
% hObject    handle to buttonTakeScan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject, 'Enable', 'off')
drawnow
robotScanHokuyo();
robotICP()
set(hObject, 'Enable', 'on')

% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Position du paneau de controle du robot
figPos = get(hObject, 'Position');
figWidth = figPos(3);
figHeight = figPos(4);
panelPos = get(handles.controlPanel, 'Position');
panelWidth = panelPos(3);
panelHeight = panelPos(4);
panelPos(1) = 2;
panelPos(2) = figHeight - panelHeight - 1;
set(handles.controlPanel, 'Position', panelPos)

% Position checkbox
chkPos = get(handles.chkApproxRT, 'Position');
chkPos(1) = 2;
chkPos(2) = panelPos(2) - 3;
set(handles.chkApproxRT, 'Position', chkPos);

% Position bouton reset
resetPos = get(handles.buttonReset, 'Position');
resetPos(1) = 2;
resetPos(2) = chkPos(2) - 8;
set(handles.buttonReset, 'Position', resetPos);

% Position des axes
axes1Pos = get(handles.axes1, 'Position');
axes2Pos = get(handles.axes2, 'Position');
axes3Pos = get(handles.axes3, 'Position');
axes4Pos = get(handles.axes4, 'Position');

spaceH = 8;
spaceV = 4;
left = panelPos(1) + panelWidth + spaceH;
right = figWidth - spaceH;
top = panelPos(2) + panelHeight - 2;
bottom = 3;
totalWidth = right - left;
totalHeight = top - bottom;
axesWidth = (totalWidth - spaceH) / 2;
axesHeight = (totalHeight - spaceV) / 2;
x1 = left;
x2 = left + axesWidth + spaceH;
x3 = left;
x4 = left + axesWidth + spaceH;
y1 = bottom + axesHeight + spaceV;
y2 = bottom + axesHeight + spaceV;
y3 = bottom;
y4 = bottom;

axes1Pos = [x1 y1 axesWidth axesHeight];
axes2Pos = [x2 y2 axesWidth axesHeight];
axes3Pos = [x3 y3 axesWidth axesHeight];
axes4Pos = [x4 y4 axesWidth axesHeight];

set(handles.axes1, 'Position', axes1Pos);
set(handles.axes2, 'Position', axes2Pos);
set(handles.axes3, 'Position', axes3Pos);
set(handles.axes4, 'Position', axes4Pos);


% --- Executes on button press in chkApproxRT.
function chkApproxRT_Callback(hObject, eventdata, handles)
% hObject    handle to chkApproxRT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global AlignementApproxICP
AlignementApproxICP = get(hObject, 'Value');


% --- Executes on button press in buttonReset.
function buttonReset_Callback(hObject, eventdata, handles)
% hObject    handle to buttonReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
resetAll()
