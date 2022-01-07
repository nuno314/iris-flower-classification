function[yy]=pp_R_K(f,a,b,h,y0)
syms x y
xx=a:h:b;
n=length(xx);
yy=zeros(1,n-1);
k1=h*subs(subs(f,x,a),y,y0);
k2=h*subs(subs(f,x,a+h/2),y,y0+k1/2);
k3=h*subs(subs(f,x,a+h),y,y0-k1+2*k2);
yy(1)=y0+(k1+4*k2+k3)/6;
for i=2:n-1
   k1=h*subs(subs(f,x,xx(i-1)),y,yy(i-1));
   k2=h*subs(subs(f,x,xx(i-1)+h/2),y,yy(i-1)+k1/2);
   k3=h*subs(subs(f,x,xx(i-1)+h),y,yy(i-1)-k1+2*k2);
   yy(i)=yy(i-1)+(k1+4*k2+k3)/6;
end
end