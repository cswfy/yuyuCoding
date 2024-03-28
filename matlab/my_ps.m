function varargout = my_ps(varargin)
% MY_PS MATLAB code for my_ps.fig
%      MY_PS, by itself, creates a new MY_PS or raises the existing
%      singleton*.
%
%      H = MY_PS returns the handle to a new MY_PS or the handle to
%      the existing singleton*.
%
%      MY_PS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MY_PS.M with the given input arguments.
%
%      MY_PS('Property','Value',...) creates a new MY_PS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before my_ps_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to my_ps_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help my_ps

% Last Modified by GUIDE v2.5 12-Jun-2019 16:49:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @my_ps_OpeningFcn, ...
                   'gui_OutputFcn',  @my_ps_OutputFcn, ...
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


% --- Executes just before my_ps is made visible.
function my_ps_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to my_ps (see VARARGIN)

% Choose default command line output for my_ps
handles.output = hObject;

% Update handles structure
handles.isAutoBright = false;
guidata(hObject, handles);


% UIWAIT makes my_ps wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = my_ps_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_open.
function btn_open_Callback(hObject, eventdata, handles)
% hObject    handle to btn_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.jpg';'*.png'});
if pathname == 0
    display('User cancelled');
else
    image_path = strcat(pathname, filename);
    
    handles.ori_rgb = imread(image_path);
    handles.processed_rgb = handles.ori_rgb;    
    guidata(hObject, handles);
    displayImages(handles);
    
end

function displayImages(handles)
    axes(handles.axes_source);		
    imshow(handles.ori_rgb);
    axes(handles.axes_processed);    
    imshow(handles.processed_rgb);


% --- Executes on slider movement.
function sldGamma_Callback(hObject, eventdata, handles)
% hObject    handle to sldGamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
process_image(handles);




% --- Executes during object creation, after setting all properties.
function sldGamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sldGamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function process_image(handles)
    if get(handles.chkAutoBright, 'Value') == 1
        [Y, U, V] = rgb2yuv(handles.ori_rgb(:,:,1), handles.ori_rgb(:,:,2), handles.ori_rgb(:,:,3));
        Y = histeq(Y);
        handles.processed_rgb = yuv2rgb(Y, U, V);
        displayImages(handles);
    else
        newGamma = get(handles.sldGamma,'Value');
        display(newGamma);
        handles.processed_rgb = luma_adjusted_rgb(handles.ori_rgb, newGamma); 
        displayImages(handles);
    end
    


% --- Executes on button press in chkAutoBright.
function chkAutoBright_Callback(hObject, eventdata, handles)
% hObject    handle to chkAutoBright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkAutoBright

    display(get(hObject,'Value'));
    if get(hObject,'Value') == 1
        set(handles.sldGamma, 'Enable', 'off');
    else
        set(handles.sldGamma, 'Enable', 'on');
    end
    process_image(handles);
