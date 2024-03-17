clear all;
close all;
load('datemotor.mat');


figure;
plot(u);
title('Semnal u');
figure;
plot(vel);
title('Semnal vel');

idu=u(1:212);
idy=vel(1:212);
valu=u(212:end);
valy=vel(212:end);


Ts=0.01;
id_model=iddata(idy',idu,Ts);
val_model=iddata(valy',valu,Ts);
uid=id_model.u;
yid=id_model.y;

na=2;
nb=2;
nk=1;
N=200;

%identificare predictie
model=arx(id_model,[na nb nk]);
ysim=compare(model,id_model);
ysim=ysim.Y;
M=length(yid);

for i=1:M
    for j=1:na
        if i>j
            fi_id(i,j)=-yid(i-j);
        end
    end
    for j=1:nb
        if i>j
            fi_id(i,j+na)=uid(i-j);
        end
    end
end

for I=1:M
    valid=zeros(1,20);
    for J=1:na
        if I>J
            valid(J)=-ysim(I-J );
        end
    end
    for J=1:nb
        if I>J
            valid(J+na)=uid(I-J);
        end
    end
    z(i,:)=valid;
end

s=0;
for k=1:N
    s=s+(z(k,:)'*fi_id(k,:));
end
fi=(1/N)*s;

s=0;
for k=1:N
    s=s+(z(k,:).*yid(k,:));
end

Y=(1/N)*s;
teta=fi\Y';
A=[1,teta(1:na)'];
B=[0,teta(na+1:na+nb)'];
C=1;
D=1;
F=1;
modelvalid=idpoly(A,B,C,D,F,0,Ts);
compare(modelvalid,val_model);

%eroarea medie patratica
suma=0;
P=valy-ysim;
for i=1:length(P)
    suma=suma+P(i).^2;
end
MSE_fin=suma/length(P)