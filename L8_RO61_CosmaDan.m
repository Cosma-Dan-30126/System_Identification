load('datemotor.mat');
nk=2;
Ts=0.01;
N=200;
alfa=0.1;
delta=10e-4;
lmax=1000;
range=0.7;
figure; 
plot(u);
figure;
plot(vel);
idu=u(1:212);
idy=vel(1:212);
validu=u(212:end);
validy=vel(212:end);
l_iteratie=0;
eroare=zeros(1,N);
eroare(1)=0;
b=1;
f=1;
teta=[b;f];
nk=2;
%dV= gradientul  si Hes= hesianul
dV=zeros(2,1);
Hdes=zeros(2,2);
while(1)
    for k=1:nk
        eroare(k)=vel(k);
    end
    f=teta(1,1);
b=teta(2,1);

deriv_errf=zeros(N,1);
deriv_errb=zeros(N,1);
dV=zeros(2,1);
Hdes=zeros(2,2);
for k=nk+1:N
 eroare(k)=vel(k)+f*(vel(k-1))-b*(u(k-nk))-f*(eroare(k-1));
 deriv_errf(k)=-f*deriv_errf(k-1)-eroare(k-1)+vel(k-1);
 deriv_errb(k)=-f*deriv_errb(k-1)-u(k-nk);
 dV=dV+2/(N-nk)*(eroare(k)*[deriv_errf(k),deriv_errb(k)]');
 Hdes=Hdes+2/(N-nk)*([deriv_errf(k); deriv_errb(k)] * [deriv_errf(k) deriv_errb(k)]);
end
copie=teta;
teta=copie-alfa*inv(Hdes)*dV;
l_iteratie=l_iteratie+1

if ((norm(teta-copie)<=delta) || (l_iteratie>=lmax))
    break;
end
end


A=1; C=1; D=1;E=1;
B=[zeros(1,nk),teta(2)];
F=[1,teta(1)];
model=idpoly(A,B,C,D,F,0,Ts);
val=iddata(validy',validu,Ts);
figure;
compare(model,val);

%Cod motor
%uz=zeros(10,1);
%uz=uz(:);
%N=200;
%u_spab=idinput(N,'prbs',[],[-0.7,0.7]);
%u_step=0.4*ones(70,1);
%u=[uz;u_spab;uz;u_step];
%[vel,alpha,t]=run(u,'/dev/ttyACM0');
%plot(t,vel)


