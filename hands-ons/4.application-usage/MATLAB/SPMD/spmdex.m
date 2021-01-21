%====================================================================
% Illustration of SPMD Parallel Programming model with MATLAB
%====================================================================
%parpool('kebnekaise', str2num(getenv('SLURM_CPUS_PER_TASK')))
parpool('kebnekaise', 4);
p = gcp; 
% Start of parallel region...........................................
spmd
  nproc = numlabs;  % get total number of workers
  iproc = labindex; % get lab ID
  if ( iproc == 1 )
fprintf ( 1, ' Running with  %d labs.n', nproc );
  end
  for i = 1: nproc
if iproc == i
   fprintf ( 1, ' Rank %d out of  %d.n', iproc, nproc );
end
  end
%% End of parallel region.............................................
end

% The expression that we wish to integrate:
f = @(x) 4./(1 + x.^2);

% Enter an SPMD block to run the enclosed code in parallel on a number
% of MATLAB workers:
spmd

  % Choose a range over which to integrate based on my unique index:
  range_start      = (labindex - 1) / numlabs;
  range_end        = labindex / numlabs;
  % Calculate my portion of the overall integral
  my_integral      = quadl( f, range_start, range_end );
  % Aggregate the result by adding together each value of ?my_integral? 
  total_integral   = gplus( my_integral );
end

total_int = total_integral{1};
fprintf('The computed value of pi is %8.7f.n',total_int);

delete(gcp);

