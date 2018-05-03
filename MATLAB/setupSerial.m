function [s,flag]=setupSerial(comPort)

flag=1;

s=serial(comPort);
set(s,'DataBits',8);
set(s,'StopBits',1);
set(s,'BaudRate',115200);
set(s,'Parity','none');
fopen(s);
fid= fopen('blah.txt','w+');

a='b';

while (a~='a')
    a=fread(s,1,'uchar');
end

if (a=='a')
    disp('serial read');
end

fprintf(s,'%c','a');
mbox=msgbox('Serial Communication Setup'); 
uiwait(mbox);
fscanf(s,'%f');
a = 'f';

junk=fread(s,s.BytesAvailable);


A=[];
count=0;

while count<100
        a=fread(s,10);
        B=[char(a')];
        
%     while a == []
%         a=fread(s,4,'uchar');
    %while a~="?"
    %
    %end
%     end

   A=[A B];

   fprintf(fid,A);
   
   count=count+1;
   
    
    
% while loop that stores the angles in the angle vector and same for
% recorded time using '?' and '!' to recognise them, then we can plot time
% vs angle


end


fclose(fid);






