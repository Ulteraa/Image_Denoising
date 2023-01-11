function [ Int ,S] = Nearest( Image, I, J )
    Size = 1;
   % A=max(max(Image));
    
    while(( 1 == 1 ))
        Xs = zeros(0, 1);
        Ys = zeros(0, 1);
        Ds = zeros(0, 1);
        Pixel_value=zeros(0, 1);
        Count = 0;
        for i = -Size : Size
            if(I + i >= 1 && I + i <= size(Image,1))
                for j = -Size : Size
                    if(J + j >= 1 && J + j <= size(Image,2))
                        if(Image(I + i, J + j) ~= 0 && Image(I + i, J + j) ~= 255)
                            Xs = [Xs, i + I];
                            Ys = [Ys, j + J];
                            %Ds = [Ds, (i * i + j * j) ^ 0.5];
                            Count = Count + 1;
                            Pixel_value=[Pixel_value,Image(I + i, J + j)];
                            
                        end
                    end
                end
            end
        end
%          if Count==1
%              Int=Image(Xs(1,Count),Ys(1,Count));
%              S=Size;
%             % display('ok')
%              return
%          end
         Pixel_value=double(Pixel_value);
        if((max(Pixel_value)-min(Pixel_value))<15)
            %Pixel_value
        %if(Count==0)
        
            Size = Size + 1;
     
        else
         Q=zeros(Count);
         Y=zeros(Count,1);
         W=zeros(Count,1);
          Dis=zeros(Count);
          Count;
          
%           if Count==1
%               Dis(Count,Count)=1;
%           else
%           for i1=1:Count
%              for j1=1:Count
%                  if (i1==j1)
%                      Dis(i1,j1)=1000;
%                  else
%                  Dis(i1,j1)=sqrt(((Xs(1,i1)-Xs(1,j1))^2+(Ys(1,i1)-Ys(1,j1))^2));
%                  end
%              end
%           end
%           end
%          
%          ep=(1/Count)*sum(min(Dis));
%          ep=1/(0.815*ep);
ep=(1/(2*Size))*(0.8*sqrt(Count));
         
         for i=1:Count
             for j=1:Count
                 Q(i,j)=((1+ep*ep*(((Xs(1,i)-Xs(1,j))^2+(Ys(1,i)-Ys(1,j))^2)))^(-1));
                 %Q(i,j)=(exp(-((Xs(1,i)-Xs(1,j))^2+(Ys(1,i)-Ys(1,j))^2)));original
                 
                 
                 
             end
         end
       
         for D=1:Count
              Y(D,1)=(exp(-double(Image(Xs(1,D),Ys(1,D)))));
      %       Y(D,1)=(double(Image(Xs(1,D),Ys(1,D))))/255;
         end
         W=inv(Q)*Y;
   
         Sum=0;
      

           for i=1:Count
             Sum=Sum+W(i,1)*((1+ep*ep*(((Xs(1,i)-I)^2+(Ys(1,i)-J)^2)))^(-1));
             %Sum=Sum+W(i,1)*(exp(-((Xs(1,i)-I)^2+(Ys(1,i)-J)^2)));original
             
           end
            
       Int=-log(abs(Sum));
     
       S=Size;
            return;
        end
    end
end

