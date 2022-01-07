function[y1,y2]=ppEuler(f,a,b,h,y0)
syms x y
xx=a:h:b;
n=length(xx);
y1=0*xx; y1(1)=y0;
for i=2:n
   fxy=subs(subs(f,x,xx(i-1)),y,y1(i-1));
   y1(i)=y1(i-1)+(xx(i)-xx(i-1))*fxy;
end

y2=0*xx; y2(1)=y0;
for i=2:n
   fx1y1=subs(subs(f,x,xx(i-1)),y,y2(i-1));
   y2(i)=y2(i-1)+(xx(i)-xx(i-1))*fx1y1;
   fx2y2=subs(subs(f,x,xx(i)),y,y2(i));
   y2(i)=y2(i-1)+(xx(i)-xx(i-1))/2*(fx1y1+fx2y2);
end
end