function[I1,delta_I1,I2,delta_I2,I3,delta_I3]=tichPhanGauss(f,a,b)
syms x
I=int(f,x,a,b);
w1=1; x12=-0.5774; t12=(b-a)*x12/2+(a+b)/2;
w2=1; x22=0.5774; t22=(b-a)*x22/2+(a+b)/2;
I1=(b-a)/2*(w1*subs(f,x,t12)+w2*subs(f,x,t22));
I1=double(I1);
delta_I1=double(abs((I-I1)/I));

w1=0.5556; x13=-0.7746; t13=(b-a)*x13/2+(a+b)/2;
w2=0.8889; x23=0; t23=(b-a)*x23/2+(a+b)/2;
w3=0.5556; x33=0.7746; t33=(b-a)*x33/2+(a+b)/2;
I2=(b-a)/2*(w1*subs(f,x,t13)+w2*subs(f,x,t23)+w3*subs(f,x,t33));
I2=double(I2);
delta_I2=double(abs((I-I2)/I));

w1=0.3479; x14=-0.8611; t14=(b-a)*x14/2+(a+b)/2;
w2=0.6521; x24=-0.3340; t24=(b-a)*x24/2+(a+b)/2;
w3=0.6521; x34=0.3340; t34=(b-a)*x34/2+(a+b)/2;
w4=0.3479; x44=0.8611; t44=(b-a)*x44/2+(a+b)/2;
I3=(b-a)/2*(w1*subs(f,x,t14)+w2*subs(f,x,t24)+w3*subs(f,x,t34)+w4*subs(f,x,t44));
I3=double(I3);
delta_I3=double(abs((I-I3)/I));
end