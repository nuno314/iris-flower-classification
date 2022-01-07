function[xn,fxn] = PPLap(f,phi,x0,Df)
syms x
k=0;
while 1
    xn=subs(phi,x,x0);
    fxn=subs(f,x,xn);
    if (abs(fxn) <= Df)
        break
    else
        x0=xn;
    end
    k=k+1;
end
k
xn=double(xn);
fxn=double(fxn);
end