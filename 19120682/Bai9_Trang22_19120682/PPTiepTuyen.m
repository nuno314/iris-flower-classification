function [fx,xn] = PPTiepTuyen(f,x0,delta,a,b)
syms x;
ezplot(f,[a,b])
df = diff(f,x)
k=1;
while 1
    xn=x0-subs(f,x,x0)/subs(df,x,x0);
    fx = subs(f,x,xn);
    xn=double(xn);
    if abs(fx) <= delta
        break
    else
        x0=xn;
    end
    k=k+1;
end
k;
fx = double(fx);
end
