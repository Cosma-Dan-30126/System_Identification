clear all;
close all;
load('dataset2.mat');
%{ N=200;
%m=3;
%a=-0.7;
%b=0.7;
%na=3;
%nb=3;
%VECTOR=zeros(1,m);
%u = [zeros(1,10),SPAB(N,m,a,b),zeros(1,10),SPAB(N,10,a,b),zeros(1,10),0.4*ones(1,70)];
%plot(u);
%Uident1=u(10:210);
%Yident1=vel(10:210);
%Uident2=u(220:420);
%Yident2=vel(220:420);
%Uvalidare= u(430:end);
%Yvalidare= vel(430:end);


%ident1=iddata(Yident1',Uident1',t(2)-t(1));
%ident2=iddata(Yident2',Uident2',t(2)-t(1));
%Validaredate=iddata(Yvalidare',Uvalidare',t(2)-t(1));

%Modelele de baza, se pot face atat cu functia arx cat si cu o metoda de
%design din laboratorul trecut
%sch_ident1=arx(ident1,[na,nb,1]);
%sch_ident2=arx(ident2,[na,nb,1]);
%sch_validare=arx(Validaredate,[na,nb,1]);

% simulam raspunsul spab-urilor pentru timp discret
%Yiddent1=lsim(sch_ident1,Uident1);
%Yiddent2=lsim(sch_ident2,Uident2);
%Yvvalid=lsim(sch_validare,Uvalidare);
%Yvvalid_sch1=lsim(sch_ident1,Uvalidare);
%Yvvalid_sch2=lsim(sch_ident2,Uvalidare);
%Yiddent1=compare(ident1,sch_ident1);
%Yiddent2=compare(ident2,sch_ident2);
%Yvvalid=compare(Validaredate,sch_validare);
% verificare cu setul de validare
%Yvvalid_sch1= compare(Validaredate,sch_ident1);
%Yvvalid_sch2=compare(Validaredate,sch_ident2);
%figure;
%plot(Yvalidare);
%figure;
%plot(Yvvalid_sch1);
%figure;
%plot(Yvvalid_sch2);
%figure;
%compare(ident1,sch_ident1);
%figure;
%compare(ident2,sch_ident2);
%figure;
%compare(Validaredate,sch_validare)
%figure;
%compare(Validaredate,sch_ident1);
%figure;
%compare(Validaredate,sch_ident2);
Model1=arx(id1,[na,nb,nk]);
Model2=arx(id2,[na,nb,nk]);
figure;
compare(Model1,val);
figure;
compare(Model2,val);
u=SPAB(200,10,0.5,1);
plot(u)


function [funct]= SPAB(N,m,a,b)
if m==3
    VECTOR(1,:)=[1,0,1];
elseif m==4
         VECTOR(1,:)=[1, 0, 0, 1];
elseif m==5
            VECTOR(1,:)=[0, 1, 0, 0, 1];
elseif m==6
        VECTOR(1,:)=[1, 0, 0, 0, 0, 1];
elseif m==7
        VECTOR(1,:)=[1, 0, 0, 0, 0, 0, 1];
elseif m==8
    VECTOR(1,:)=[1, 1, 0, 0, 0, 0, 1, 1];
elseif m==9
    VECTOR(1,:)=[0, 0, 0, 1, 0, 0, 0, 0, 1];
elseif m==10
    VECTOR(1,:)=[0 0 1 0 0 0 0 0 0 1]; 
end
loccurent=ones(1,m);
locnext=zeros(1,m);

for j=1:N
    locnext(1)=mod(sum(VECTOR.*loccurent),2);
    locnext(2:end)= loccurent(1:end-1);
    u(j)=locnext(1);
    loccurent=locnext;	
end
funct=a+(b-a)*u;
end

