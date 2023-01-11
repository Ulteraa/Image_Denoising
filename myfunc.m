function [b] = myfunc(I)
b=1;
for x=1:size(I,1),
    for y=1:size(I,2),                
    if I(x,y)==0 || I(x,y)==255
        b=0;
        return;
    end
    end
end
end