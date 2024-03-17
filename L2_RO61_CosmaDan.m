clear all;
load('lab2_03.mat')
id.X;
id.Y;
val.X;
val.Y;
plot(id.X,id.Y);
hold on
plot(val.X,val.Y);
VAL_MSE=zeros(1,length(val.X));
for n= 1:8
N=length(id.Y);
fi=zeros(N,n)
for j=1:1:N
    for I=1:1:n
        fi(j,I)=id.X(j)^(I-1);
    end
end
    theta=fi\id.Y';
    y_id=fi*theta;

    M=length(val.Y);

    for j=1:1:M
        for I=1:1:n
            ffi(j,I)=val.X(j)^(I-1);
        end
    end
    y_val=ffi*theta;
%MSE
S=0;
for j=1:M
S=S+(val.Y(j)-y_val(j));
end
MSE_val=((1/M)*sum(S)).^2;
VAL_MSE(n)=MSE_val;

end
figure;
plot(val.X,val.Y,val.X,y_val)
figure;
plot(1:length(VAL_MSE),VAL_MSE)
hold on





