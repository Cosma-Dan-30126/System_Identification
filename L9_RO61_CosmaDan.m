clear all;
load('motorell.mat');
na=6;
nb=6;
nk=1;
figure;
plot(u);
figure;
plot(vel);
idu=u(1:212);
idy=vel(1:212);
validu=u(212:end);
validy=vel(212:end);
%N=length(idu);
M=length(idy);
% stim ca timpul folosit e de 10 ms asa ca T=0.01
model_ident=iddata(idy',idu,0.01);

%folosim functia arx a matlab-ului pentru a implementa etapa identificarii
IDmod=arx(model_ident,[na nb nk]);
Yhat=lsim(IDmod,idu);
validaremod=iddata(validy',validu,0.01);

% se ia N=212 cu scopul de a semnala sfarsitul semnalului de identificare 
Nbun=212;
lungime_Yhat=length(Yhat);
lungime_identu=length(idu);
Ntotal=na+nb;
Z=zeros(Nbun,Ntotal);
for i=1:Nbun
    for j=1:na
        if(i>j &&i-j<=lungime_Yhat)
           Z(i,j)=-Yhat(i-j); 
        end
    end


    for j=1:nb
    if(i>j &&i-j<=lungime_identu)
           Z(i,j+na)=idu(i-j); 
    end
    end
end
teta=Z\Yhat;
Yfin=Z*teta;

A=[1,teta(1:na)'];
B=[0,teta(na+1:end)'];
VI=idpoly(A,B,1,1,1,0,0.01);
figure;
compare(validaremod,VI);
figure;
compare(validaremod,IDmod);
Yhatfin=lsim(VI,validu);
figure
plot(validy);
hold on
plot(Yhatfin);







