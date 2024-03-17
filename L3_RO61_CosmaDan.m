clear all;
load('lab3_order1_2');
x=data.Inputdata;
y=data.Outputdata;
figure;
plot(x)
title('Intrare ordin 1')
figure
plot(y)
title('Iesire ordin 1')
Y0=0;
YSS=mean(y(50:100));
U0=0;
Uss=0.5;
% H(s)=K/(T*s+1)
K=((YSS-Y0)/(Uss-U0));
t1=0;
t2=t(23);
%t2=Y0+(YSS-Y0)*0.632;
T=(t2-t1)*90/100;
H=tf(K,[T,1]);
Yhat=lsim(H,x,t);
hold on
figure
plot(Yhat)
figure
plot(t,y,t,Yhat)
title('Comparare aproximare de ordin 1');
legend('y','Yhat');

%MSE
MSE=1/length(y)*sum(y-Yhat)^2;


%%
clear all;
load('lab3_order2_2.mat');
x=data.Inputdata;
y=data.Outputdata;
figure;
plot(x);
title('Intrare ordin 2');
figure 
plot(y);
title('Iesire ordin 2')
Y0=y(1);
YSS=6.11;
Ymax=max(y(1:100));
U0=0;
Uss=1.5;
% (K*wn^2)/(s^2+2*TiTa*wn*s+wn^2)
K=(YSS-Y0)/(Uss-U0);
M=(Ymax-YSS)/(YSS-Y0);
TiTa=(-log(M))/(sqrt(pi^2+log(M)^2));
t1=t(15);
t2=t(44);
BigT=t2-t1;
wn=(2*pi)/(BigT*sqrt(1-TiTa^2));
Numarator=K*wn^2;
R=2*TiTa*wn;
F=wn^2;
H=tf([Numarator],[1,R,F]);
Yhat=lsim(H,x,t);
hold on
figure
plot(Yhat)
figure
plot(t,y,t,Yhat)
title('Comparare aproximare de ordin 2');
legend('y','Yhat')

%MSE
MSE=1/length(y)*sum(y-Yhat)^2;











