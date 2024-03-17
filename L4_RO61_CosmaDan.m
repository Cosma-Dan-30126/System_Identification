clear all;
load('lab4_order1_6.mat');
x=data.Inputdata;
y=data.Outputdata;
figure;
plot(x)
title('Intrare ordin 1')
figure
plot(y)
title('Iesire ordin 1');
%Yss e aceelasi lucru cu Y0
YSS=y(1);
Ymax=0.284;
Uss=0.5;
K=YSS/Uss;
Calct=0.368*(Ymax-YSS)+YSS;
t1=t(31);
t2=t(45);
T=t2-t1;
OrdA=-1/T;
OrdB=K/T;
OrdC=1;
OrdD=0;
H2=ss(OrdA,OrdB,OrdC,OrdD);
figure
Yhat2=lsim(H2,x,t,YSS)
plot(Yhat2)
figure
plot(t,y,t,Yhat2)
title('Raspunsul la impuls');
legend('y','Yhat')

%MSE
MSE=1/length(y)*sum(y-Yhat2)^2;

%%
clear all;
load('lab4_order2_6.mat');
x=data.Inputdata;
y=data.Outputdata;
figure;
plot(x);
title('Intrare ordin 2');
figure 
plot(y);
title('Iesire ordin 2');
YSS=y(1);
XSS=x(1);
K=YSS/XSS;

t1=t(39);
t2=t(82);
%k0=t(31);
k0=31;
%k1=t(54);
k1=54;
%k2=t(78);
k2=78;
BigT=t2-t1;
Ts=t(40)-t(39);

Amin_neterm = 0;
for k=k1:k2
    Amin_neterm=Amin_neterm+(2.4486-y(k));
end
Aminus=Ts*Amin_neterm;

Amax_neterm = 0;
for k=k0:k1
    Amax_neterm=Amax_neterm+(y(k)-2.4486);
end
Aplus=Ts*Amax_neterm;
M=Aminus/Aplus;
TiTa=(-log(M))/(sqrt(pi^2+log(M)^2));
wn=(2*pi)/(BigT*sqrt(1-TiTa^2));
F=wn^2;
A=[0 1;-F -2*TiTa*wn];
B=[0; K*wn^2];
C=[1 0];
D=0;
H2=ss(A,B,C,D);
Yhat=lsim(H2,x,t,[YSS 0]);
figure;
hold on
plot(Yhat)
figure
plot(t,y,t,Yhat)
title('Raspunsul la impuls la gradul 2');
legend('y','Yhat')


%MSE
MSE=1/length(y)*sum(y-Yhat)^2











