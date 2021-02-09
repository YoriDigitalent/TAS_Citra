function varargout = GUI_DCT(varargin)
% GUI_DCT MATLAB code for GUI_DCT.fig
%      GUI_DCT, by itself, creates a new GUI_DCT or raises the existing
%      singleton*.
%
%      H = GUI_DCT returns the handle to a new GUI_DCT or the handle to
%      the existing singleton*.
%
%      GUI_DCT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_DCT.M with the given input arguments.
%
%      GUI_DCT('Property','Value',...) creates a new GUI_DCT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_DCT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_DCT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_DCT

% Last Modified by GUIDE v2.5 24-Jul-2020 22:18:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_DCT_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_DCT_OutputFcn, ...
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


% --- Executes just before GUI_DCT is made visible.
function GUI_DCT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_DCT (see VARARGIN)

% Choose default command line output for GUI_DCT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_DCT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_DCT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pilih.
function pilih_Callback(hObject, eventdata, handles)
% hObject    handle to pilih (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im2
[name_file1,name_path1] = uigetfile( ...
    {'*.bmp;*.jpg;*.tif','Files of type (*.bmp,*.jpg,*.tif)';
    '*.bmp','File Bitmap (*.bmp)';...
    '*.jpg','File jpeg (*.jpg)';
    '*.tif','File Tif (*.tif)';
    '*.*','All Files (*.*)'},...
    'Open Image');
 
if ~isequal(name_file1,0)
    im = imread(fullfile(name_path1,name_file1));
    guidata(hObject,handles);
    axes(handles.axes1);
    im2=rgb2gray(im); %converts to double
    im2=im2; %untuk proses backup
    imshow(im2);
    
    axes(handles.axes2);
    imhist(im2);

else
    return;
end


% --- Executes on button press in dct.
function dct_Callback(hObject, eventdata, handles)
% hObject    handle to dct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2

%J = dct2(im);
%imshow(log(abs(J)),[]), colormap(jet(64)), colorbar
%J(abs(J) > 150) = 50;
%z1 = idct2(J);

Y1 = blkproc(im2,[8 8],@FastDCT);
z1 = blkproc(Y1,[8 8],@FastIDCT);

axes(handles.axes3);
imshow(uint8(z1));

axes(handles.axes4);
imshow(uint8(Y1));

axes(handles.axes9);
imhist(uint8(z1));

global im3
Y1 = im2double(Y1);
im3 = Y1;

% --- Executes on button press in ghe_dct.
function ghe_dct_Callback(hObject, eventdata, handles)
% hObject    handle to ghe_dct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2
x = histeq(im2);

%J = dct2(x);
%imshow(log(abs(J)),[]), colormap(jet(64)), colorbar
%J(abs(J) > 150) = 50;
%z2 = idct2(J);

Y2 = blkproc(x,[8 8],@FastDCT);
z2 = blkproc(Y2,[8 8],@FastIDCT);

axes(handles.axes5);
imshow(uint8(z2));

axes(handles.axes6);
imshow(uint8(Y2));

K = imadjust(uint8(z2),[],[0.6 0.9]);
axes(handles.axes10);
imhist(K);

global im4
Y2 = im2double(Y2);
im4 = Y2;


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
cla reset

axes(handles.axes2)
cla reset

axes(handles.axes3)
cla reset

axes(handles.axes4)
cla reset

axes(handles.axes5)
cla reset

axes(handles.axes6)
cla reset

axes(handles.axes7)
cla reset

axes(handles.axes8)
cla reset

axes(handles.axes9)
cla reset

axes(handles.axes10)
cla reset

axes(handles.axes11)
cla reset


% --- Executes on button press in ghedctsvd.
function ghedctsvd_Callback(hObject, eventdata, handles)
% hObject    handle to ghedctsvd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im3
global im4

[U1, S1, V1] = svd(im3);
[U2, S2, V2] = svd(im4);

%w adalah koefisien nilai singular
w = max(S2) / max(S1);

Snew = w*S2;

Y3 = U1 * Snew * V1';
z3 = blkproc(Y3,[8 8],@FastIDCT);

axes(handles.axes7);
imshow(uint8(z3));

axes(handles.axes8);
imshow(uint8(Y3));

axes(handles.axes11);
imhist(uint8(z3));

global imdone
a = uint8(z3);
a = im2double(a);
imdone = a;


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imdone
axes(handles.axes7);
[FileName, PathName] = uiputfile('*.jpg*', 'Save As');
Name = fullfile(FileName, PathName);
imwrite(imdone, 'Name', 'jpg');
