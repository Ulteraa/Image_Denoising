clc;
close all;
tic
%YY=imread('barbara.png');
I= imread('barbara.png');
%YY(1:30,260:272)
%I=rgb2gray(I1);
I(1:512 ,260:272)=0;
u=zeros(size(I,1),size(I,2));
My=zeros(size(I,1),size(I,2));
Number=0;
Number1=0;
J = imnoise(I,'salt & pepper', 0.8);
%J=I;
J=double(J);

for i=1:size(I,1)
    for j=1:size(I,2)
        
        if(J(i, j) == 0 || J(i, j) == 255)
            
             Number=Number+1;          
       
       
        else
                  
             Number1=Number1+1;          
       
        end
        
    end
end
Res=zeros(1,Number);
Size=zeros(1,Number);
ref=zeros(1,Number1);
e=1;
e1=1;
%J=Y;
%J=double(J);


for i=1:size(I,1)
    for j=1:size(I,2)
        if(J(i, j) == 0 || J(i, j) == 255)
            %   I(i,j)
            [Res(e),Size(e)]=Nearest(J, i, j);
            
          
%             u(i,j)=Res(e);
%             if(Size(e)>4)
%                 Res(e)=0;
%                 Size(e);
%             end
            e=e+1;
           
        else
            ref(e1)=(J(i, j));
            e1=e1+1;
            
        end
    end
end

e=1;
for i=1:size(I,1)
    for j=1:size(I,2)
        if(J(i, j) == 0 || J(i, j) == 255)
           
%             if(Res(e)==0)
%                 ar=zeros(1,9);
%                in=1;
%                 if i~=1 && j~=1 && i~=size(I,1) && j~=size(I,2)
%                    for tt=-1:1
%                        for ttt=-1:1
%                         ar(in)=u(i+tt,j+ttt) ;
%                         in=in+1;
%                        end
%                    end
%                 end
%                 Res(e)=mean(ar);
%                 
%             end
      
            u(i, j) =Res(e);
           % J(i,j)=Res(e);
            e=e+1;
          
                       
        else
            u(i, j) = J(i, j);
        
        end
    end
end


 %    fin=u;
%  
%   ou=Gussian_Filter(u);
%    for x=1:size(I,1),
%        for y=1:size(I,2), 
%         if(J(x, y) == 0 || J(x, y) == 255)
%              u(x,y)=ou(x,y);
%          else
%    
%    u(x,y)=fin(x,y);
%          end
%          
%         end
%    end

e=1; 
 for x=1:size(I,1)
      for y=1:size(I,2) 
       if(J(x, y) == 0 || J(x, y) == 255)
 
       s =0;
          normal=0;
          
for i=-Size(e):Size(e)           
              for j=-Size(e):Size(e)
                  if((x+i>0)&&(x+i<size(I,1)+1)&&(y+j>0)&&(y+j<size(I,2)+1))
                 s = s +(u(x+i,y+j))*(exp(sqrt(i^2+j^2)));
                normal=normal+(exp(sqrt(i^2+j^2)));
                  end
   
             end
        end       
          u(x,y) = s/normal;
%           if abs(Res(e)-I(x,y))<abs(u(x,y)-I(x,y))
%               
%               u(x,y)=Res(e);
%           else
%               u(x,y)=u(x,y);
%           end
%             Res(e)
%             u(x,y)
%             I(x,y)
%             Size(e)
          e=e+1;
       
       end
       
      end
 end
 
 e=1;
 display('iiii');
   for x=1:size(I,1)
       for y=1:size(I,2) 
     if((J(x, y) == 0 || J(x, y) == 255))
        if((x-Size(e)>0)&&(x+Size(e)<size(I,1)+1)&&(y-Size(e)>0)&&(y+Size(e)<size(I,2)+1))
            fa=u(x-Size(e):x+Size(e),y-Size(e):y+Size(e));
            %if(u(x,y)==min(fa(:))||u(x,y)==max(fa(:)))
             A= mean(fa(:));
               va=(fa-A).^2;
               B=sum(va(:));
               B=(1/((2*Size(e)+1)^2)-1)*B;
               B=sqrt(B);
                  if (u(x,y)<A-B)
                      u(x,y)=median(fa(:));
%                 while (u(x,y)<A-B)
%                    u(x,y)=u(x,y)+B; 
%             
%                 end
                end
                
               if (u(x,y)>A+B)
                   
                  u(x,y)=median(fa(:));
%                 while (u(x,y)>A+B)
%                    u(x,y)=u(x,y)-B; 
%             
%                 end
                end


 
              
         end       
          
           e=e+1;
        
        end
        
       end
   end
 
 
 
u=uint8(u);

display('uu')



u1=double(u);
J1=double(J);
u1(1:30,260:272)
I1=double(I);Difer=I1-u1;
Tem1=sum(sum((J1-I1).^2));
Tem2=sum(sum((u1-I1).^2));
IEF=Tem1/Tem2
Kparametr=[0.01 0.03];
 window = fspecial('gaussian', 11, 1.5);
t=ssim(u1,I1,Kparametr,window,255);
t
J1 = sum(sum((u1-I1).^2))/(size(I,1)*size(I,2));
J1=10*log10((255^2)/J1)

imshow(J, []), title('Noise');
figure, imshow(u, []), title('Restore');
%figure, imshow(Difer, []), title('res');
n=toc;
n

