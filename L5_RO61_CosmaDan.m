clear all;
load("lab5_4.mat");

uID=id.u;
yID=id.y;
uVAL=val.u;
yVAL=val.y;
figure;
plot(uID)
figure
plot(yID)

UIDDET=detrend(uID);
YIDDET=detrend(yID);

figure;
plot(UIDDET);
figure;
plot(YIDDET);
M=length(UIDDET);
N=length(YIDDET);
m=80;

Ru=zeros(1,N);
Ryu=zeros(1,N);

for Ttau=1:N
    
    ru_interm=0;
    ryu_interm=0;
    for k=1:N-Ttau
        ru_interm=ru_interm+(UIDDET(k+Ttau-1)*UIDDET(k));
    end
     %Ru(Ttau)=(1/N)*ru_interm;
    Ru(Ttau)=ru_interm/N;

     for k=1:N-Ttau
        ryu_interm=ryu_interm+(YIDDET(k+Ttau-1)*UIDDET(k));
     end
    Ryu(Ttau)=(1/N)*ryu_interm;
    end

%Pas final: Structurare matrice si plot pentru afisare
RU_MAT=zeros(N,m);
RYU_MAT=zeros(N,1);
    for i=1:1:N
        RYU_MAT(i,1)=Ryu(i);
        for j=1:1:m
            
            RU_MAT(i,j)=Ru(abs(i-j)+1);
        end
    end
    
    Hd=RU_MAT\RYU_MAT;
    figure;
    plot(Hd);
    YHAT=conv(Hd,uVAL);
    figure;
    plot(YHAT(1:length(uVAL)));
    hold on
   plot(yVAL);
   


   %MSE
   R = yVAL - YHAT(1:length(yVAL));
   Suma_MSE=0;
   for i=1:m
Suma_MSE=Suma_MSE+R(i)^2;
   end
   MSE=sum(Suma_MSE)/length(R);
