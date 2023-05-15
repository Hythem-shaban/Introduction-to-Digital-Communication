t=0:1/4000:1;
x=sin(2*pi*2.*t);%generate sin wave -> amp=1, freq=2, fs=4000
figure;
plot(t,x)

n_vector=[3 4 5 10];
quantization_error=[];
for i=1:1:4
    Accumulator=0;
    n=n_vector(i);
    m=2*n+1; %m -> number of bits (n bits for integer+fractional and one bit for sign)
    y=double(fi(x,1,m,n)); %creates a fixed-point object with fraction length specified by n.
    binary=dec2bin(y);%returns the binary, or base-2, representation of the number y.
    figure;
    plot(t,y)
    for j=1:1:length(y)
        error=(y(j)-x(j)).^2;
        Accumulator=Accumulator+error;
    end
    Accumulator=(1/length(y)).*Accumulator;
    quantization_error=[quantization_error Accumulator];
end
figure;
plot(n_vector, quantization_error);
%%