clear all;
close all;
load('matlab.mat');
figure;
plot(u);
figure;
plot(speed);
id_y= speed(11:217);
id_u=u(11:217);
val_y= speed(221:290);
val_u=u(221:290);
N=length(id_y);
M=length(val_y);
nA=4;
nB=4;

% Metoda Predictiei
for I=1:N
    for J=1:nA
        if I>J
            fii(I,J)=-id_y(abs(I-J));
        end

        for J=1:nB
        if I>J
            fii(I,J+nA)=id_u(abs(I-J));
        end
        
    end
    end
end
teta=fii\id_y';
Y_ident=fii*teta;

figure;
plot(id_y);
hold on;
plot(Y_ident);



for R=1:M
    for Q=1:nA
        if R>Q
            fii_val(R,Q)=-val_y(abs(R-Q));
        end

        for Q=1:nB
        if R>Q
            fii_val(R,Q+nA)=val_u(abs(R-Q));
        end
        
    end
    end
end
Y_valid=fii_val*teta;

figure;
plot(val_y);
hold on;
plot(Y_valid);

%Metoda Simularii
for i=1:M
  valid = zeros(1,nA+nB);
    for j=1: nA
        if i>j
            valid(j)=-Y_simulare_validare(abs(i-j));
        end

    end

    for j=1:nB
      if i>j
    valid(j+nA)=val_u(abs(i-j));
    end
Y_simulare_validare(i)=valid*teta;
    end
end

figure;
plot(Y_simulare_validare);
hold on;
plot(val_y);

%MSE
s=0;
mse=val_y-Y_simulare_validare;
for i=1:length(mse)
    s=s+mse(i).^2;
end
MSE_finv=s/length(mse);