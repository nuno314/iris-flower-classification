function[I1,delta_I1,I2,delta_I2,I3,delta_I3]=tichphanso_3_N_C(xx,yy,I)
n=length(xx);
I1=0;
for i=2:n
    I1=I1+(xx(i)-xx(i-1))*(yy(i)+yy(i-1))/2;
end
delta_I1 = abs((I-I1)/I);

I2=0;
for i=3:2:n
    I2=I2+(xx(i)-xx(i-2))*(yy(i)+4*yy(i-1)+yy(i-2))/6;
end
delta_I2 = abs((I-I2)/I);

I3=0;
for i=4:3:n
    I3=I3+(xx(i)-xx(i-3))*(yy(i)+3*yy(i-1)+3*yy(i-2)+yy(i-3))/8;
end
delta_I3 = abs((I-I3)/I);
end