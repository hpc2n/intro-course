function funct(sz)

format long
A1 = rand(sz*100,sz*100);
tic;
B1 = fft(A1);
time1 = toc;
filename = sprintf('log_size_%s.out',num2str(sz*100));
mid=fopen(filename,'w');
fprintf(mid,'Matrix size %d * %d \n',sz*100,sz*100);
fprintf(mid,'Time = %16.12f\n',time1);
fclose(mid);
%
end
