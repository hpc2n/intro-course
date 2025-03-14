% Get a handle to the cluster
% See the page for configuring and setup of MATLAB > 2018b for details
c=parcluster('kebnekaise')
% Run the job on CPU
j = c.batch(@mandelcpu, 1, {})
% Wait till the job has finished. Use j.State if you just want to poll the
% status and be able to do other things while waiting for the job to finish.
j.wait
% Fetch the result after the job has finished
j.fetchOutputs{:}
