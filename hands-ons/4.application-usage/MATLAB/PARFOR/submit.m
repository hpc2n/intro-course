% Get a handle to the cluster
% See the page for configuring and setup of MATLAB for details
c=parcluster('kebnekaise')
% Run the jobs on 4 workers
j = c.batch(@parallel_example, 1, {32}, 'pool', 2)
% Wait till the job has finished. Use j.State if you just want to poll the
% status and be able to do other things while waiting for the job to finish.
j.wait
% Fetch the result after the job has finished
j.fetchOutputs{:}