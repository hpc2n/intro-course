% Get a handle to the cluster
% See the page for configuring and setup of MATLAB > 2018b for details
c=parcluster('kebnekaise')
% If you want v100 GPUs and only need one card:
c.AdditionalProperties.GpuCard = 'v100';
c.AdditionalProperties.GpusPerNode = 1;
% Run the job
j = c.batch(@mandelgpu, 1, {})
% Wait till the job has finished. Use j.State if you just want to poll the
% status and be able to do other things while waiting for the job to finish.
j.wait
% Fetch the result after the job has finished
j.fetchOutputs{:}
