%close all;
%clc
%I = imread('lena.png');
%I(5:10,5:10)
function [ out_put ]=Gussian_Filter( I )
TT=I;
R=double(I);
U=zeros(3);
Res=zeros(512);
I=double(I);
I2 = I;
F=zeros(1,3);
for i=2:511
    
    for j=2:511
        A=[I(i,j-1)+I(i,j)+I(i,j+1);
            I(i-1,j)+I(i,j)+I(i+1,j);
            I(i-1,j-1)+I(i,j)+I(i+1,j+1);
            I(i-1,j+1)+I(i,j)+I(i+1,j-1)]' / 3;
        M = mean(A);
        II = I(i-1:i+1,j-1:j+1);
        m = max(II(:));
        n = min(II(:));
        
        for p=1:3
            for q=1:3
                if(II(p,q)>M)
                    U(p,q)=(m-II(p,q))/(m-M);
                else
                    U(p,q)=(II(p,q)-n)/(M-n);
                end
            end
        end
       
        [p, q] = find(max(U(:)) == U, 1);
       I(i, j) = II(p, q);
       AA=median(II(:));
      % KK=abs(AA-I(i,j));
       KK=0;
        %Res(i,j)=II(p, q);
        if (U(2, 2) <0.95)
            I2(i, j) = 255;
        end
    end
end
%---------------------------------------------------------------------------------
%--------------------------------------------------------------------------------
Res=I;
%for E=1:1
for i=3:510
    
    for j=3:510
       II = I(i-1:i+1,j-1:j+1);
        m = max(II(:));
        n = min(II(:));
        F(1)=min(Small(I(i-2,j)-I(i-1,j),m,n),Small(I(i-1,j)-I(i,j),m,n));
        F(2)=min(Small(I(i-1,j)-I(i,j),m,n),Small(I(i,j)-I(i+1,j),m,n));
        F(3)=min(Small(I(i,j)-I(i+1,j),m,n),Small(I(i-2,j)-I(i-1,j),m,n));
        U(1,2)=max(F) ;
        %------------------------
        F(1)=min(Small(I(i+2,j)-I(i+1,j),m,n),Small(I(i+1,j)-I(i,j),m,n));
        F(2)=min(Small(I(i+1,j)-I(i,j),m,n),Small(I(i,j)-I(i-1,j),m,n));
        F(3)=min(Small(I(i,j)-I(i-1,j),m,n),Small(I(i+2,j)-I(i+1,j),m,n));
        U(3,2)=max(F) ;
        %-----------------------
        
         F(1)=min(Small(I(i,j-2)-I(i,j-1),m,n),Small(I(i,j-1)-I(i,j),m,n));
        F(2)=min(Small(I(i,j-1)-I(i,j),m,n),Small(I(i,j)-I(i,j+1),m,n));
        F(3)=min(Small(I(i,j)-I(i,j+1),m,n),Small(I(i,j-2)-I(i,j-1),m,n));
        U(2,1)=max(F) ;
        %----------------
         F(1)=min(Small(I(i,j+1)-I(i,j),m,n),Small(I(i,j+2)-I(i,j+1),m,n));
        F(2)=min(Small(I(i,j+1)-I(i,j),m,n),Small(I(i,j)-I(i,j-1),m,n));
        F(3)=min(Small(I(i,j)-I(i,j-1),m,n),Small(I(i,j+2)-I(i,j+1),m,n));
        U(2,3)=max(F) ;
        %--------------------
       F(1)=min(Small(I(i+2,j+2)-I(i+1,j+1),m,n),Small(I(i+1,j+1)-I(i,j),m,n));
        F(2)=min(Small(I(i+1,j+1)-I(i,j),m,n),Small(I(i,j)-I(i-1,j-1),m,n));
        F(3)=min(Small(I(i,j)-I(i-1,j-1),m,n),Small(I(i+2,j+2)-I(i+1,j+1),m,n));
        U(3,3)=max(F) ;
        %----------------------
         F(1)=min(Small(I(i-2,j-2)-I(i-1,j-1),m,n),Small(I(i-1,j-1)-I(i,j),m,n));
        F(2)=min(Small(I(i-1,j-1)-I(i,j),m,n),Small(I(i,j)-I(i+1,j+1),m,n));
        F(3)=min(Small(I(i,j)-I(i+1,j+1),m,n),Small(I(i-2,j-2)-I(i-1,j-1),m,n));
        U(1,1)=max(F) ;
        %------------------
        F(1)=min(Small(I(i-2,j+2)-I(i-1,j+1),m,n),Small(I(i-1,j+1)-I(i,j),m,n));
        F(2)=min(Small(I(i-1,j+1)-I(i,j),m,n),Small(I(i,j)-I(i+1,j-1),m,n));
        F(3)=min(Small(I(i,j)-I(i+1,j-1),m,n),Small(I(i-2,j+2)-I(i-1,j+1),m,n));
        U(1,3)=max(F) ;
        %----------------
         F(1)=min(Small(I(i+1,j-1)-I(i,j),m,n),Small(I(i+2,j-2)-I(i+1,j-1),m,n));
        F(2)=min(Small(I(i+1,j-1)-I(i,j),m,n),Small(I(i,j)-I(i-1,j+1),m,n));
        F(3)=min(Small(I(i,j)-I(i-1,j+1),m,n),Small(I(i+2,j-2)-I(i+1,j-1),m,n));
        U(3,1)=max(F) ;
        %----------------------------------
  %---------------------------------------------------------------------------------------
  B=U(1,3)*(I(i-1,j+1)-I(i,j))+U(3,1)*(I(i+1,j-1)-I(i,j))+U(1,1)*(I(i-1,j-1)-I(i,j))+U(3,3)*(I(i+1,j+1)-I(i,j))+U(1,2)*(I(i-1,j)-I(i,j))+U(3,2)*(I(i+1,j)-I(i,j))+U(2,1)*(I(i,j-1)-I(i,j))+U(2,3)*(I(i,j+1)-I(i,j));
       I(i,j)=I(i,j)+B/((sum(sum(U))-U(2,2)));
    end
end
%end
out_put=I;

end

