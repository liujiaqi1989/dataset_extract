clc
clear all;
%%
[filename, pathname, filterindex] = uigetfile('*.*', 'Pick an xml-file');
F=[pathname,filename];
xDoc=xmlread(F);
xRoot = xDoc.getDocumentElement;
schema = char(xRoot.getAttribute('name'));
frames=xRoot.getElementsByTagName('frame');
Num_frames=frames.getLength;
c=cell(1,Num_frames);
for i=0:Num_frames-1
    c1=zeros(5,1);
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
     c{1,i+1}=c1;
end
%%
fileType = '*.png';
fileType2 = '.png';
file_doc1 = 'View_001';

file_dataset='datasets/Sunnyday';
file_dataset2='Sunnyday';
%ImageSequence = dir([file_dataset '/' file_doc1 '/' fileType])';
ImageSequence = dir([file_dataset '/' file_doc1 '/' fileType])';
for i = 1 : Num_frames
      
        %ImageSequence(i).Image_loc = [file_dataset '/' file_doc1 '/' ImageSequence(i).name];
        ImageSequence(i).Image_loc = [file_dataset '/' file_doc1 '/' ImageSequence(i).name];
        ImageSequence(i).Im = double(imread(ImageSequence(i).Image_loc));
end

%%
[m,n,q]=size(ImageSequence(1).Im);
a=1;
IDvector=[];
for i=1:Num_frames
    if any(c{1,i})
    [~,cns]=size(c{1,i});
  for j=1:cns
      p=c{1,i};
      if p(5,j)-p(2,j)/2+1>0 && p(4,j)-p(3,j)/2+1>0 && p(5,j)+p(2,j)/2<=m && p(4,j)+p(3,j)/2<=n
         image= ImageSequence(i).Im(p(5,j)-p(2,j)/2+1:p(5,j)+p(2,j)/2,p(4,j)-p(3,j)/2+1:p(4,j)+p(3,j)/2,:);
      elseif p(5,j)-p(2,j)/2+1>0 && p(4,j)-p(3,j)/2+1>0 && p(5,j)+p(2,j)/2<=m && p(4,j)+p(3,j)/2>n
         image= ImageSequence(i).Im(p(5,j)-p(2,j)/2+1:p(5,j)+p(2,j)/2,p(4,j)-p(3,j)/2+1:end,:);
      elseif p(5,j)-p(2,j)/2+1>0 && p(4,j)-p(3,j)/2+1>0 && p(5,j)+p(2,j)/2>m && p(4,j)+p(3,j)/2<=n
         image= ImageSequence(i).Im(p(5,j)-p(2,j)/2+1:end,p(4,j)-p(3,j)/2+1:p(4,j)+p(3,j)/2,:);
      elseif p(5,j)-p(2,j)/2+1>0 && p(4,j)-p(3,j)/2+1>0 && p(5,j)+p(2,j)/2>m && p(4,j)+p(3,j)/2>n
         image= ImageSequence(i).Im(p(5,j)-p(2,j)/2+1:end,p(4,j)-p(3,j)/2+1:end,:);
      elseif p(5,j)-p(2,j)/2+1>0 && p(4,j)-p(3,j)/2+1<=0 && p(5,j)+p(2,j)/2<=m && p(4,j)+p(3,j)/2<=n
         image= ImageSequence(i).Im(p(5,j)-p(2,j)/2+1:p(5,j)+p(2,j)/2,1:p(4,j)+p(3,j)/2,:);
      elseif p(5,j)-p(2,j)/2+1>0 && p(4,j)-p(3,j)/2+1<=0 && p(5,j)+p(2,j)/2<=m && p(4,j)+p(3,j)/2>n
         image= ImageSequence(i).Im(p(5,j)-p(2,j)/2+1:p(5,j)+p(2,j)/2,1:end,:); 
      elseif p(5,j)-p(2,j)/2+1>0 && p(4,j)-p(3,j)/2+1<=0 && p(5,j)+p(2,j)/2>m && p(4,j)+p(3,j)/2<=n
         image= ImageSequence(i).Im(p(5,j)-p(2,j)/2+1:end,1:p(4,j)+p(3,j)/2,:); 
      elseif p(5,j)-p(2,j)/2+1>0 && p(4,j)-p(3,j)/2+1<=0 && p(5,j)+p(2,j)/2>m && p(4,j)+p(3,j)/2>n
         image= ImageSequence(i).Im(p(5,j)-p(2,j)/2+1:end,1:end,:); 
      elseif p(5,j)-p(2,j)/2+1<=0 && p(4,j)-p(3,j)/2+1>0 && p(5,j)+p(2,j)/2<=m && p(4,j)+p(3,j)/2<=n
         image= ImageSequence(i).Im(1:p(5,j)+p(2,j)/2,p(4,j)-p(3,j)/2+1:p(4,j)+p(3,j)/2,:);
      elseif p(5,j)-p(2,j)/2+1<=0 && p(4,j)-p(3,j)/2+1>0 && p(5,j)+p(2,j)/2<=m && p(4,j)+p(3,j)/2>n
          image= ImageSequence(i).Im(1:p(5,j)+p(2,j)/2,p(4,j)-p(3,j)/2+1:end,:);
      elseif p(5,j)-p(2,j)/2+1<=0 && p(4,j)-p(3,j)/2+1>0 && p(5,j)+p(2,j)/2>m && p(4,j)+p(3,j)/2<=n  
          image= ImageSequence(i).Im(1:end,p(4,j)-p(3,j)/2+1:p(4,j)+p(3,j)/2,:);
      elseif p(5,j)-p(2,j)/2+1<=0 && p(4,j)-p(3,j)/2+1>0 && p(5,j)+p(2,j)/2>m && p(4,j)+p(3,j)/2>n 
          image= ImageSequence(i).Im(1:end,p(4,j)-p(3,j)/2+1:end,:);
      elseif p(5,j)-p(2,j)/2+1<=0 && p(4,j)-p(3,j)/2+1<=0 && p(5,j)+p(2,j)/2<=m && p(4,j)+p(3,j)/2<=n
          image= ImageSequence(i).Im(1:p(5,j)+p(2,j)/2,1:p(4,j)+p(3,j)/2,:);
      elseif p(5,j)-p(2,j)/2+1<=0 && p(4,j)-p(3,j)/2+1<=0 && p(5,j)+p(2,j)/2<=m && p(4,j)+p(3,j)/2>n
          image= ImageSequence(i).Im(1:p(5,j)+p(2,j)/2,1:end,:);
      elseif p(5,j)-p(2,j)/2+1<=0 && p(4,j)-p(3,j)/2+1<=0 && p(5,j)+p(2,j)/2>m && p(4,j)+p(3,j)/2<=n
          image= ImageSequence(i).Im(1:end,1:p(4,j)+p(3,j)/2,:);
      elseif p(5,j)-p(2,j)/2+1<=0 && p(4,j)-p(3,j)/2+1<=0 && p(5,j)+p(2,j)/2>m && p(4,j)+p(3,j)/2>n
          image= ImageSequence(i).Im(1:end,1:end,:);
      end            
   image=uint8(image);
   if any(IDvector==c{1,i}(1,j));
       % imwrite(image,[file_dataset2, '_extract','/Object',num2str(c{1,i}(1,j)),'/Frame',num2str(i-1),fileType2]);
        imwrite(image,[file_dataset2, '_extract','/Object',num2str(c{1,i}(1,j)),'/', ImageSequence(i).name]);
    else
        mkdir([file_dataset2,'_extract'],['Object',num2str(c{1,i}(1,j))]);
        %imwrite(image,[file_dataset2, '_extract', '/Object',num2str(c{1,i}(1,j)),'/Frame',num2str(i-1),fileType2]);
        imwrite(image,[file_dataset2, '_extract','/Object',num2str(c{1,i}(1,j)),'/', ImageSequence(i).name]);
        IDvector(a)=c{1,i}(1,j);
        a=a+1;
   end
  end
    end
end
display('Extracting is successful !');
%%
for i=1:a-1
    ImageExtract = dir([[file_dataset2, '_extract'] '/' ['Object', num2str(IDvector(i))] '/' fileType])';
    Framenum=length(ImageExtract);
    Area=zeros(Framenum,1);
    for j=1:Framenum
    ImageExtract(j).Image_loc=[[file_dataset2, '_extract'] '/' ['Object', num2str(IDvector(i))] '/' ImageExtract(j).name];
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
        imwrite(image,[file_dataset2, '_extract','/Object',num2str(IDvector(i)),'/',ImageExtract(j).name]);
    end
end
display('Scaling is successful !');
