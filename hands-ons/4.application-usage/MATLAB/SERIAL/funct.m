function funct(sz)

format long
A1 = rand(sz,sz);
tic;
B1 = fft(A1);
time1 = toc;

filename = 'log.out';
mid=fopen(filename,'w');
fprintf(mid,'Time = %16.12f\n',time1);
fclose(mid);
%
end
