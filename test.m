clear all
% [filename, pathname, filterindex] = uigetfile('*.*', 'Pick an xml-file');
% F=[pathname,filename];
% xDoc=xmlread(F);
% %xDoc=xmlread('gt/PETS2009/PETS2009-S2L1-cropped.xml');
% xRoot = xDoc.getDocumentElement;
% schema = char(xRoot.getAttribute('name'));
% frames=xRoot.getElementsByTagName('frame');
% Num_frames=frames.getLength;
% c1=zeros(5,1);
% c=cell(1,Num_frames);
% for i=0:Num_frames-1
%     frameelement=frames.item(i);
%     frameid=char(frameelement.getAttribute('number'));
%     object=frameelement.getElementsByTagName('object');
%     Num_object=object.getLength;
%     for j=0:Num_object-1
%         objectelement=object.item(j);
%         objectid=char(objectelement.getAttribute('id'));
%         boxes=objectelement.getElementsByTagName('box');
%         box=boxes.item(0);
%         h=char(box.getAttribute('h'));
%         w=char(box.getAttribute('w'));
%         xc=char(box.getAttribute('xc'));
%         yc=char(box.getAttribute('yc'));
%         c1(1,j+1)=str2double(objectid);
%         c1(2,j+1)=str2double(h);
%         c1(3,j+1)=str2double(w);
%         c1(4,j+1)=str2double(xc);
%         c1(5,j+1)=str2double(yc);
%     end
%      c{1,i+1}=c1;
% end
%     
[filename, pathname, filterindex] = uigetfile('*.*', 'Pick an xml-file');
 F=[pathname,filename];
 im=double(imread(F));
 figure
 imshow(im/256);
 saveas()

