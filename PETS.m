function varargout = PETS(varargin)
% PETS MATLAB code for PETS.fig
%      PETS, by itself, creates a new PETS or raises the existing
%      singleton*.
%
%      H = PETS returns the handle to a new PETS or the handle to
%      the existing singleton*.
%
%      PETS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PETS.M with the given input arguments.
%
%      PETS('Property','Value',...) creates a new PETS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PETS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PETS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PETS

% Last Modified by GUIDE v2.5 19-Aug-2015 15:03:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PETS_OpeningFcn, ...
                   'gui_OutputFcn',  @PETS_OutputFcn, ...
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


% --- Executes just before PETS is made visible.
function PETS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PETS (see VARARGIN)


% Choose default command line output for PETS
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PETS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PETS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ImportData.
function ImportData_Callback(hObject, eventdata, handles)
% hObject    handle to ImportData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count file_dataset
count=1;
set(handles.uitable1,'RowName',{'ID','h','w','xc','yc'},'data',[]);
FrameNum=10;
%%
[filename, pathname, filterindex] = uigetfile('*.*', 'Pick an xml-file');
F=[pathname,filename];
xDoc=xmlread(F);
xRoot = xDoc.getDocumentElement;
schema = char(xRoot.getAttribute('name'));
frames=xRoot.getElementsByTagName('frame');
Num_frames=frames.getLength;
c1=zeros(5,1);
handles.c=cell(1,Num_frames);
for i=0:Num_frames-1
    frameelement=frames.item(i);
    frameid=char(frameelement.getAttribute('number'));
    object=frameelement.getElementsByTagName('object');
    Num_object=object.getLength;
    for j=0:Num_object-1
        objectelement=object.item(j);
        objectid=char(objectelement.getAttribute('id'));
        boxes=objectelement.getElementsByTagName('box');
        box=boxes.item(0);
        h=char(box.getAttribute('h'));
        w=char(box.getAttribute('w'));
        xc=char(box.getAttribute('xc'));
        yc=char(box.getAttribute('yc'));
        c1(1,j+1)=str2double(objectid);
        c1(2,j+1)=str2double(h);
        c1(3,j+1)=str2double(w);
        c1(4,j+1)=str2double(xc);
        c1(5,j+1)=str2double(yc);
    end
     handles.c{1,i+1}=c1;
end

%%
%file_dataset='Crowd_PETS09S2L1';
fileType = '*.jpg';
file_doc1 = 'View_001';
file_doc2 = 'View_002';
file_doc3 = 'View_003';
file_doc4 = 'View_004';
file_doc5 = 'View_005';
file_doc6 = 'View_006';
file_doc7 = 'View_007';
file_doc8 = 'View_008';
filefolder='Users/liujiaqi/Documents/MAtLAB/PETS/datasets'; %path for hard disk
%filefolder='Volumes/JADE';%path for USB stick
%%
if strcmp(file_dataset,'Crowd_PETS09S2L1/S2/L1/Time_12-34')
    
handles.ImageSequence1 = dir(['/' filefolder '/' file_dataset '/' file_doc1 '/' fileType])';
handles.ImageSequence3 = dir(['/' filefolder '/' file_dataset '/' file_doc3 '/' fileType])';
handles.ImageSequence4 = dir(['/' filefolder '/' file_dataset '/' file_doc4 '/' fileType])';
handles.ImageSequence5 = dir(['/' filefolder '/' file_dataset '/' file_doc5 '/' fileType])';
handles.ImageSequence6 = dir(['/' filefolder '/' file_dataset '/' file_doc6 '/' fileType])';
handles.ImageSequence7 = dir(['/' filefolder '/' file_dataset '/' file_doc7 '/' fileType])';
handles.ImageSequence8 = dir(['/' filefolder '/' file_dataset '/' file_doc8 '/' fileType])';
handles.NumImage = length(handles.ImageSequence1);
%% Read data from USB stick
% handles.NumImage = length(handles.ImageSequence1)/2;
% handles.ImageSequence1(1:handles.NumImage)=[];
% handles.ImageSequence3(1:handles.NumImage)=[];
% handles.ImageSequence4(1:handles.NumImage)=[];
% handles.ImageSequence5(1:handles.NumImage)=[];
% handles.ImageSequence6(1:handles.NumImage)=[];
% handles.ImageSequence7(1:handles.NumImage)=[];
% handles.ImageSequence8(1:handles.NumImage)=[];

%%
for i = 1 : handles.NumImage
        %%
        handles.ImageSequence1(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc1 '/' handles.ImageSequence1(i).name];
        handles.ImageSequence1(i).Im = double(imread(handles.ImageSequence1(i).Image_loc));
        %%
        handles.ImageSequence3(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc3 '/' handles.ImageSequence3(i).name];
        handles.ImageSequence3(i).Im = double(imread(handles.ImageSequence3(i).Image_loc));
        %%
        handles.ImageSequence4(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc4 '/' handles.ImageSequence4(i).name];
        handles.ImageSequence4(i).Im = double(imread(handles.ImageSequence4(i).Image_loc));
        %%
        handles.ImageSequence5(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc5 '/' handles.ImageSequence5(i).name];
        handles.ImageSequence5(i).Im = double(imread(handles.ImageSequence5(i).Image_loc));
        %%
        handles.ImageSequence6(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc6 '/' handles.ImageSequence6(i).name];
        handles.ImageSequence6(i).Im = double(imread(handles.ImageSequence6(i).Image_loc));
        %%
        handles.ImageSequence7(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc7 '/' handles.ImageSequence7(i).name];
        handles.ImageSequence7(i).Im = double(imread(handles.ImageSequence7(i).Image_loc));
        %%
        handles.ImageSequence8(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc8 '/' handles.ImageSequence8(i).name];
        handles.ImageSequence8(i).Im = double(imread(handles.ImageSequence8(i).Image_loc));
end
   
%%
cla(handles.axes2);
imshow(handles.ImageSequence1(1).Im/256, 'Parent', handles.axes1);
imshow(handles.ImageSequence3(1).Im/256, 'Parent', handles.axes3);
imshow(handles.ImageSequence4(1).Im/256, 'Parent', handles.axes4);
imshow(handles.ImageSequence5(1).Im/256, 'Parent', handles.axes5);
imshow(handles.ImageSequence6(1).Im/256, 'Parent', handles.axes6);
imshow(handles.ImageSequence7(1).Im/256, 'Parent', handles.axes7);
imshow(handles.ImageSequence8(1).Im/256, 'Parent', handles.axes8);

else if strcmp(file_dataset,'Crowd_PETS09S3MF/S3/Multiple_Flow/Time_12-43')
        
handles.ImageSequence1 = dir(['/' filefolder '/' file_dataset '/' file_doc1 '/' fileType])';
handles.ImageSequence2 = dir(['/' filefolder '/' file_dataset '/' file_doc2 '/' fileType])';
handles.ImageSequence5 = dir(['/' filefolder '/' file_dataset '/' file_doc5 '/' fileType])';
handles.ImageSequence6 = dir(['/' filefolder '/' file_dataset '/' file_doc6 '/' fileType])';
handles.ImageSequence7 = dir(['/' filefolder '/' file_dataset '/' file_doc7 '/' fileType])';
handles.ImageSequence8 = dir(['/' filefolder '/' file_dataset '/' file_doc8 '/' fileType])';
handles.NumImage = length(handles.ImageSequence1);
%% Read data from USB stick
% handles.NumImage = length(handles.ImageSequence1)/2;
% handles.ImageSequence1(1:handles.NumImage)=[];
% handles.ImageSequence3(1:handles.NumImage)=[];
% handles.ImageSequence4(1:handles.NumImage)=[];
% handles.ImageSequence5(1:handles.NumImage)=[];
% handles.ImageSequence6(1:handles.NumImage)=[];
% handles.ImageSequence7(1:handles.NumImage)=[];
% handles.ImageSequence8(1:handles.NumImage)=[];

%%
for i = 1 : handles.NumImage
        %%
        handles.ImageSequence1(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc1 '/' handles.ImageSequence1(i).name];
        handles.ImageSequence1(i).Im = double(imread(handles.ImageSequence1(i).Image_loc));
        %%
        handles.ImageSequence2(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc2 '/' handles.ImageSequence2(i).name];
        handles.ImageSequence2(i).Im = double(imread(handles.ImageSequence2(i).Image_loc));
        %%
        handles.ImageSequence5(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc5 '/' handles.ImageSequence5(i).name];
        handles.ImageSequence5(i).Im = double(imread(handles.ImageSequence5(i).Image_loc));
        %%
        handles.ImageSequence6(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc6 '/' handles.ImageSequence6(i).name];
        handles.ImageSequence6(i).Im = double(imread(handles.ImageSequence6(i).Image_loc));
        %%
        handles.ImageSequence7(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc7 '/' handles.ImageSequence7(i).name];
        handles.ImageSequence7(i).Im = double(imread(handles.ImageSequence7(i).Image_loc));
        %%
        handles.ImageSequence8(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc8 '/' handles.ImageSequence8(i).name];
        handles.ImageSequence8(i).Im = double(imread(handles.ImageSequence8(i).Image_loc));
end
   
%%
cla(handles.axes3);
cla(handles.axes4);
imshow(handles.ImageSequence1(1).Im/256, 'Parent', handles.axes1);
imshow(handles.ImageSequence2(1).Im/256, 'Parent', handles.axes2);
imshow(handles.ImageSequence5(1).Im/256, 'Parent', handles.axes5);
imshow(handles.ImageSequence6(1).Im/256, 'Parent', handles.axes6);
imshow(handles.ImageSequence7(1).Im/256, 'Parent', handles.axes7);
imshow(handles.ImageSequence8(1).Im/256, 'Parent', handles.axes8);
      
    else
        handles.ImageSequence1 = dir(['/' filefolder '/' file_dataset '/' file_doc1 '/' fileType])';
        handles.ImageSequence2 = dir(['/' filefolder '/' file_dataset '/' file_doc1 '/' fileType])';
        handles.ImageSequence3 = dir(['/' filefolder '/' file_dataset '/' file_doc3 '/' fileType])';
        handles.ImageSequence4 = dir(['/' filefolder '/' file_dataset '/' file_doc4 '/' fileType])';
        handles.NumImage = length(handles.ImageSequence1);
%% Read data from USB stick
% handles.NumImage = length(handles.ImageSequence1)/2;
% handles.ImageSequence1(1:handles.NumImage)=[];
% handles.ImageSequence3(1:handles.NumImage)=[];
% handles.ImageSequence4(1:handles.NumImage)=[];
% handles.ImageSequence5(1:handles.NumImage)=[];
% handles.ImageSequence6(1:handles.NumImage)=[];
% handles.ImageSequence7(1:handles.NumImage)=[];
% handles.ImageSequence8(1:handles.NumImage)=[];

%%
for i = 1 : handles.NumImage
        %%
        handles.ImageSequence1(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc1 '/' handles.ImageSequence1(i).name];
        handles.ImageSequence1(i).Im = double(imread(handles.ImageSequence1(i).Image_loc));
        %%
        handles.ImageSequence2(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc2 '/' handles.ImageSequence2(i).name];
        handles.ImageSequence2(i).Im = double(imread(handles.ImageSequence2(i).Image_loc));
        %%
        handles.ImageSequence3(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc3 '/' handles.ImageSequence3(i).name];
        handles.ImageSequence3(i).Im = double(imread(handles.ImageSequence3(i).Image_loc));
        %%
        handles.ImageSequence4(i).Image_loc = ['/' filefolder '/' file_dataset '/' file_doc4 '/' handles.ImageSequence4(i).name];
        handles.ImageSequence4(i).Im = double(imread(handles.ImageSequence4(i).Image_loc));
        
        
        
end
   
%%
cla(handles.axes5);
cla(handles.axes6);
cla(handles.axes7);
cla(handles.axes8);
imshow(handles.ImageSequence1(1).Im/256, 'Parent', handles.axes1);
imshow(handles.ImageSequence2(1).Im/256, 'Parent', handles.axes2);
imshow(handles.ImageSequence3(1).Im/256, 'Parent', handles.axes3);
imshow(handles.ImageSequence4(1).Im/256, 'Parent', handles.axes4);

    end
end
        
handles.An=handles.c{1,count};
Annotation=handles.An;
[~,cn]=size(Annotation);
cl=['y','m','c','r','g','b','k'];
axes(handles.axes1);
for i=1:cn
    x=[Annotation(4,i)-Annotation(3,i)/2,Annotation(4,i)+Annotation(3,i)/2,Annotation(4,i)+Annotation(3,i)/2,Annotation(4,i)-Annotation(3,i)/2,Annotation(4,i)-Annotation(3,i)/2];
    y=[Annotation(5,i)-Annotation(2,i)/2,Annotation(5,i)-Annotation(2,i)/2,Annotation(5,i)+Annotation(2,i)/2,Annotation(5,i)+Annotation(2,i)/2,Annotation(5,i)-Annotation(2,i)/2];
    id=Annotation(1,i);
    
    hold on;
    text(Annotation(4,i)-10,Annotation(5,i)-55,num2str(id),'color',cl(mod(i,7)+1));
    hold on;
    plot(x,y,'color',cl(mod(i,7)+1));
    
end
set(handles.uitable1,'RowName',{'ID','h','w','xc','yc'},'data',Annotation);
guidata(hObject, handles);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Extract.
function Extract_Callback(hObject, eventdata, handles)
% hObject    handle to Extract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count file_dataset2
[~,cns]=size(handles.An);
handles.An=round(handles.An);
a=1;
handles.IDvector=[];
% Area=zeros(1,cns);
% for i=1:cns
%     Area(i)=handles.An(2,i)*handles.An(3,i);
% end
% [~,cnm]=max(Area);
for i=1:cns
   image=handles.ImageSequence1(count).Im(handles.An(5,i)-handles.An(2,i)/2+1:handles.An(5,i)+handles.An(2,i)/2,handles.An(4,i)-handles.An(3,i)/2+1:handles.An(4,i)+handles.An(3,i)/2,:);
%    if i~=cnm
%        image_new=imresize(image,[handles.An(2,cnm),handles.An(3,cnm)]);
%    end
   image=uint8(image);
   if any(handles.IDvector==handles.An(1,i));
        imwrite(image,[file_dataset2, '_extract','/Object',num2str(handles.An(1,i)),'/Frame',num2str(count-1),'.jpg']);
    else
        mkdir([file_dataset2,'_extract'],['Object',num2str(handles.An(1,i))]);
        imwrite(image,[file_dataset2, '_extract', '/Object',num2str(handles.An(1,i)),'/Frame',num2str(count-1),'.jpg']);
        handles.IDvector(a)=handles.An(1,i);
        a=a+1;
    end
end
handles.ObjectNum=a;
guidata(hObject, handles);
set(handles.result,'string','Extracting is successful !');



% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global count file_dataset
count=count+1;
set(handles.result,'string','');
if strcmp(file_dataset,'Crowd_PETS09S2L1/S2/L1/Time_12-34')
imshow(handles.ImageSequence1(count).Im/256, 'Parent', handles.axes1);
imshow(handles.ImageSequence3(count).Im/256, 'Parent', handles.axes3);
imshow(handles.ImageSequence4(count).Im/256, 'Parent', handles.axes4);
imshow(handles.ImageSequence5(count).Im/256, 'Parent', handles.axes5);
imshow(handles.ImageSequence6(count).Im/256, 'Parent', handles.axes6);
imshow(handles.ImageSequence7(count).Im/256, 'Parent', handles.axes7);
imshow(handles.ImageSequence8(count).Im/256, 'Parent', handles.axes8);
else if strcmp(file_dataset,'Crowd_PETS09S3MF/S3/Multiple_Flow/Time_12-43')
        imshow(handles.ImageSequence1(count).Im/256, 'Parent', handles.axes1);
        imshow(handles.ImageSequence2(count).Im/256, 'Parent', handles.axes2);
        imshow(handles.ImageSequence5(count).Im/256, 'Parent', handles.axes5);
        imshow(handles.ImageSequence6(count).Im/256, 'Parent', handles.axes6);
        imshow(handles.ImageSequence7(count).Im/256, 'Parent', handles.axes7);
        imshow(handles.ImageSequence8(count).Im/256, 'Parent', handles.axes8);
    else
        imshow(handles.ImageSequence1(count).Im/256, 'Parent', handles.axes1);
        imshow(handles.ImageSequence2(count).Im/256, 'Parent', handles.axes2);
        imshow(handles.ImageSequence3(count).Im/256, 'Parent', handles.axes3);
        imshow(handles.ImageSequence4(count).Im/256, 'Parent', handles.axes4);
    end
end
%%
handles.An=handles.c{1,count};
Annotation=handles.An;
[~,cn]=size(Annotation);
cl=['y','m','c','r','g','b','k'];
axes(handles.axes1);
for i=1:cn
    x=[Annotation(4,i)-Annotation(3,i)/2,Annotation(4,i)+Annotation(3,i)/2,Annotation(4,i)+Annotation(3,i)/2,Annotation(4,i)-Annotation(3,i)/2,Annotation(4,i)-Annotation(3,i)/2];
    y=[Annotation(5,i)-Annotation(2,i)/2,Annotation(5,i)-Annotation(2,i)/2,Annotation(5,i)+Annotation(2,i)/2,Annotation(5,i)+Annotation(2,i)/2,Annotation(5,i)-Annotation(2,i)/2];
    id=Annotation(1,i);
    
    hold on;
    text(Annotation(4,i)-10,Annotation(5,i)-55,num2str(id),'color',cl(mod(i,7)+1));
    hold on;
    plot(x,y,'color',cl(mod(i,7)+1));
    
end
set(handles.uitable1,'RowName',{'ID','h','w','xc','yc'},'data',Annotation);
guidata(hObject, handles);








% % --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global file_dataset file_dataset2
val=get(hObject,'value');
str=get(hObject,'string');
switch str{val}
    case 'PETS2009S1L1_13-57'
        file_dataset='Crowd_PETS09S1L1/S1/L1/Time_13-57';
        file_dataset2='PETS2009S1L1_13-57';
    case 'PETS2009S1L1_13-59'
        file_dataset='Crowd_PETS09S1L1/S1/L1/Time_13-59';
        file_dataset2='PETS2009S1L1_13-59';
    case 'PETS2009S1L2_14-06'
        file_dataset='Crowd_PETS09S1L2/S1/L2/Time_14-06';
        file_dataset2='PETS2009S1L2_14-06';
    case 'PETS2009S1L2_14-31'
        file_dataset='Crowd_PETS09S1L2/S1/L2/Time_14-31';
        file_dataset2='PETS2009S1L2_14-31';
    case 'PETS2009S2L1_12-34'
        file_dataset='Crowd_PETS09S2L1/S2/L1/Time_12-34';
        file_dataset2='PETS2009S2L1_12-34';
    case 'PETS2009S2L2_14-55'
        file_dataset='Crowd_PETS09S2L2/S2/L2/Time_14-55';
        file_dataset2='PETS2009S2L2_14-55';
    case 'PETS2009S2L3_14-41'
        file_dataset='Crowd_PETS09S2L3/S2/L3/Time_14-41';
        file_dataset2='PETS2009S2L3_14-41';
    case 'PETS2009S3MF_12-43'
        file_dataset='Crowd_PETS09S3MF/S3/Multiple_Flow/Time_12-43';
        file_dataset2='PETS2009S3MF_12-43';
end
        

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Scale.
function Scale_Callback(hObject, eventdata, handles)
% hObject    handle to Scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global file_dataset2
set(handles.result,'string','');
fileType = '*.jpg';
filefolder='Users/liujiaqi/Documents/MAtLAB/PETS';
a=handles.ObjectNum-1;
ID=handles.IDvector;

for i=1:a
    ImageExtract = dir(['/' filefolder '/' [file_dataset2, '_extract'] '/' ['Object', num2str(ID(i))] '/' fileType])';
    Framenum=length(ImageExtract);
    Area=zeros(Framenum,1);
    for j=1:Framenum
    ImageExtract(j).Image_loc=['/' filefolder '/' [file_dataset2, '_extract'] '/' ['Object', num2str(ID(i))] '/' ImageExtract(j).name];
    ImageExtract(j).Im=double(imread(ImageExtract(j).Image_loc));
    [h,w,~]=size(ImageExtract(j).Im);
    ImageExtract(j).h=h;
    ImageExtract(j).w=w;
    Area(j)=h*w;
    end
    [s,~]=find(Area==max(Area),1);
    for j=1:Framenum
        if j~=s
        ImageExtract(j).Im=imresize(ImageExtract(j).Im,[ImageExtract(s).h,ImageExtract(s).w]);
        end
        image=uint8(ImageExtract(j).Im);
        %imwrite(image,[file_dataset2, '_extract','/Object',num2str(ID(i)),'/',ImageExtract(j).name, '_new','.jpg']);
        imwrite(image,[file_dataset2, '_extract','/Object',num2str(ID(i)),'/',ImageExtract(j).name]);
    end
end
set(handles.result,'string','Scaling is successful !');





function result_Callback(hObject, eventdata, handles)
% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of result as text
%        str2double(get(hObject,'String')) returns contents of result as a double


% --- Executes during object creation, after setting all properties.
function result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
