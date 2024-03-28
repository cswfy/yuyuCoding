function varargout = pswh(varargin)
% PSWH MATLAB code for pswh.fig
%      PSWH, by itself, creates a new PSWH or raises the existing
%      singleton*.
%
%      H = PSWH returns the handle to a new PSWH or the handle to
%      the existing singleton*.
%
%      PSWH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PSWH.M with the given input arguments.
%
%      PSWH('Property','Value',...) creates a new PSWH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pswh_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pswh_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pswh

% Last Modified by GUIDE v2.5 12-Jun-2019 21:00:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pswh_OpeningFcn, ...
                   'gui_OutputFcn',  @pswh_OutputFcn, ...
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


% --- Executes just before pswh is made visible.
function pswh_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pswh (see VARARGIN)

% Choose default command line output for pswh
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pswh wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pswh_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn.
function btn_Callback(hObject, eventdata, handles)
% hObject    handle to btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.jpg';'*.png'});
if pathname == 0
    display('User cancelled');
else
    image_path = strcat(pathname, filename);
    handles.ori_rgb = imread(image_path);
    handles.two_rgb = handles.ori_rgb;
    guidata(hObject,handles);
    displayImages(handles);
end
function displayImages(handles)
    axes(handles.axes_one);
    imshow(handles.ori_rgb);
    axes(handles.axes_two);
    imshow(handles.two_rgb);
% --- Executes on slider movement.
function slidergamma_Callback(hObject, eventdata, handles)
% hObject    handle to slidergamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
newGamma = get(hObject,'Value');
handles.two_rgb = luma_adjusted_rgb(handles.ori_rgb,newGamma);
guidata(hObject,handles);
displayImages(handles);

% --- Executes during object creation, after setting all properties.
function slidergamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slidergamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Auto.
function Auto_Callback(hObject, eventdata, handles)
% hObject    handle to Auto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Auto

display(get(hObject,'Value'));

function process_image(handles)
    if get(get(hObject,'Value')) == 1
        [Y, U, V] = rgb2yuv(handles.ori_rgb(:,:,1), handles.ori_rgb(:,:,2), handles.ori_rgb(:,:,3));
        Y = histeq(Y);
        handles.processed_rgb = yuv2rgb(Y, U, V);
        displayImages(handles);
    else
        newGamma = get(get(hObject,'Value'));
        display(newGamma);
        handles.processed_rgb = luma_adjusted_rgb(handles.ori_rgb, newGamma); 
        displayImages(handles);
    end
