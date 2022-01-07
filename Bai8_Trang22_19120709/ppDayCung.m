function[c,fc] = ppDayCung(f,a,b,delta)
syms x
k=1;
while 1
    c = a-subs(f,x,a)*(b-a)/(subs(f,x,b)-subs(f,x,a));
    c = double(c);
    fc = subs(f,x,c);
    if abs(fc) <=delta
        break
    end
    dau = sign(subs(f,x,a)*subs(f,x,c));
    if dau >0
        a=c;
    else
        b=c;
    end
    k=k+1;
end
k
fc=double(fc);
end
        
