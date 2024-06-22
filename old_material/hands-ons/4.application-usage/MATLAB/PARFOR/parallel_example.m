function t = parallel_example(iter) 
t0 = tic; 

parfor idx = 1:iter 
    A(idx) = idx; 
    pause(2) 
end 

t = toc(t0);