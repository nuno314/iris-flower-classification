function[c,fc] = ppChiaDoi(f,a,b,Df)
syms x
k=0;
while 1
    fa=subs(f,x,a);
    c=(a+b)/2;
    fc=subs(f,x,c);
    if (abs(fc) <= Df)
        break
    end
    dau=sign(fa*fc);
    if (dau > 0)
        a=c;
    else
        b=c;
    k=k+1;
    end
end
k
fc=double(fc);
end